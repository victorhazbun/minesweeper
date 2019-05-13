require 'json_web_token'

module Api
  module V1
    class AuthenticationsController < ApiController
      skip_before_action :authenticate

      def create
        user = User.by_lower_email(user_params[:email]).first
        if user&.authenticate(user_params[:password])
          render json: {
            token: JsonWebToken.encode(user_id: user.id)
          }, status: :ok
        else
          render_unauthorized(errors: [I18n.t('errors.unauthorized')])
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end