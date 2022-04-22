# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    user_id = params[:id]
    session[:token] = Token.create_user_token(user_id)
    redirect_to root_path
  end

  def require_authorization
    # NOTE KI not here
  end
end
