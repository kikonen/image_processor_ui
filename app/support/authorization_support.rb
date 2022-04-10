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
    session[:token] = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyIjoiNWRmMGY0MmQtMDE2NC00M2NlLTg3ZGEtMjQxNzZkNjkzNjdjIiwiZXhwIjoxNjQ5NjY2MzI0fQ.LnOonio1q3P5ZwD954QdchXgjkt71-CTx1sh4f-_lKQ"
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
