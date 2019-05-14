require 'json_web_token'
module AuthHelper
  def auth_token(payload)
    JsonWebToken.encode(payload)
  end
end
