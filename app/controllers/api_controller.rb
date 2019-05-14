require 'json_web_token'

class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: [I18n.t('errors.not_found')] }, status: :not_found
  end

  before_action :authenticate!

  def authenticate!
    @current_user = User.find(decoded_auth_header[:user_id])
  rescue
    render json: { errors: [I18n.t('errors.unauthorized')] }, status: :unauthorized
  end

  protected

  def current_user
    @current_user
  end

  def encode(payload)
    JsonWebToken.encode(payload)
  end

  private

  def decoded_auth_header
    auth_header = request.headers['X-Authorization-Token']&.split(' ')&.last
    JsonWebToken.decode(auth_header)
  end
end