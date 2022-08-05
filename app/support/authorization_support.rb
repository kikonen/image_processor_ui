# frozen_string_literal: true

module AuthorizationSupport
  def require_authorization
    check_jwt_token
  end

  def check_jwt_token
    jwt = fetch_request_jwt
    current_user
  end

  def fetch_request_jwt
    @request_jwt ||= begin
      jwt_token = fetch_request_token
      raise JWT::ExpiredSignature unless jwt_token
      Token.parse_token(jwt_token)
    end
  end

  def fetch_request_token
    token = session[:token]
    unless token
      # TODO KI fake token
      fake_token = Secret['FAKE_TOKEN']
      if fake_token.present?
        token = fake_token
      end
    end
    token
  end

  def current_user
    @current_user ||= begin
      jwt = fetch_request_jwt
      if jwt[:system]
        User.system_user
      else
        user_id = jwt[:user]
        response = ApiRequest.new.get(
          url: "/users/#{user_id}",
          token: fetch_request_token)
        return User.null_user unless response.success?
        User.new(response.content)
      end
    end
  end
end
