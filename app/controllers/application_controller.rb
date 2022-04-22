class ApplicationController < ActionController::Base
  include AuthorizationSupport

  rescue_from JWT::ExpiredSignature, with: :response_unauthenticated

  before_action :require_authorization

  def response_unauthenticated
    redirect_to '/auth/login'
  end
end
