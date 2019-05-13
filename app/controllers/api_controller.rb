require 'json_web_token'

class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_unauthorized(errors: [exception.message])
  end

  rescue_from JWT::DecodeError do |exception|
    render_unauthorized(errors: [exception.message])
  end

  before_action :authenticate

  def authenticate
    @current_user = User.find(decoded_auth_header[:user_id])
  end

  protected

  def render_unauthorized(errors:)
    render json: { errors: errors }, status: :unauthorized
  end

  private

  def decoded_auth_header
    auth_header = request.headers['Authorization']&.split(' ')&.last
    JsonWebToken.decode(auth_header)
  end
end