require 'rails_helper'
require 'swagger_helper'

describe 'API V1 Authentications' do
  let(:the_user) { create(:user) }

  path '/api/v1/authentication' do
    post 'Authenticates' do
      tags 'Authentications'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }

      response '200', 'authenticated' do
        let(:user) do
          {
            email: the_user.email,
            password: the_user.password
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            token: a_kind_of(String)
          )
        end
      end

      response '401', 'unauthorized' do
        let(:user) do
          {
            email: the_user.email,
            password: the_user.password.reverse
          }
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: ['Your credentials combination are invalid']
          )
        end
      end
    end
  end
end