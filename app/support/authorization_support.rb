# frozen_string_literal: true

module AuthorizationSupport
  SYSTEM_USER = User.new(
    id: User::SYSTEM_ID,
    email: 'system@local')

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
      Token.parse_token(jwt_token)
    end
  end

  def fetch_request_token
    # TODO KI fake token
    fake_token = Secret['FAKE_TOKEN']
    if fake_token.present?
      session[:token] = fake_token
    end
    session[:token]
  end

  def current_user
    @current_user ||= begin
      jwt = fetch_request_jwt
      if jwt[:system]
        SYSTEM_USER
      else
        user_id = jwt[:user]
        data = ApiRequest.new.get(
          url: "/users/#{user_id}",
          token: fetch_request_token)
        User.new(data)
      end
    end
  end
end
