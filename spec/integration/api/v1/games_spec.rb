require 'rails_helper'
require 'swagger_helper'

describe 'API V1 Games' do
  before do
    Timecop.freeze(Time.local(2019, 9, 1, 10, 5, 0))
  end

  after do
    Timecop.return
  end

  let(:user) { create(:user) }
  let(:token) { auth_token(user_id: user.id) }
  let(:game_attributes) { attributes_for(:game) }
  let(:now) { DateTime.current }

  path '/api/v1/games' do
    post 'Creates a game' do
      tags 'Games'
      consumes 'application/json'
      parameter name: 'X-Authorization-Token', in: :header, type: :string
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          started_at: { type: :string },
          rows: { type: :integer },
          cols: { type: :integer }
        },
        required: [ 'started_at', 'rows', 'cols' ]
      }

      response '201', 'valid params' do
        let(:'X-Authorization-Token') { token }
        let(:game) do
          {
            game: {
              started_at: now,
              rows: game_attributes[:rows],
              cols: game_attributes[:cols]
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            data: {
              id: a_kind_of(String),
              type: 'game',
              attributes: {
                started_at: '2019-09-01T15:05:00Z',
                finished_at: nil
              }
            }
          )
        end
      end

      response '400', 'invalid params' do
        let(:'X-Authorization-Token') { token }
        let(:game) do
          {
            game: {
              started_at: DateTime.current.iso8601
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: [
              'Rows can\'t be blank',
              'Cols can\'t be blank'
            ]
          )
        end
      end

      response '401', 'unauthorized' do
        let(:'X-Authorization-Token') { token.reverse }
        let(:game) do
          {
            game: {
              started_at: now,
              rows: game_attributes[:rows],
              cols: game_attributes[:cols]
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: ['you are not authorized to perform this action']
          )
        end
      end
    end
  end

  path '/api/v1/games/{id}' do
    put 'Update a game' do
      tags 'Games'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'X-Authorization-Token', in: :header, type: :string
      parameter name: :game, in: :body, schema: {
        type: :object,
        properties: {
          finished_at: { type: :string }
        },
        required: [ 'finished_at' ]
      }

      response '200', 'valid params' do
        let(:id) { create(:game, user: user, started_at: now).id }
        let(:'X-Authorization-Token') { token }
        let(:game) do
          {
            game: {
              finished_at: now + 1.hour
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            data: {
              id: a_kind_of(String),
              type: 'game',
              attributes: {
                started_at: '2019-09-01T15:05:00Z',
                finished_at: '2019-09-01T16:05:00Z'
              }
            }
          )
        end
      end

      response '400', 'invalid params' do
        let(:id) { create(:game, user: user, started_at: now).id }
        let(:'X-Authorization-Token') { token }
        let(:game) do
          {
            game: {
              finished_at: now - 1.hour
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: [
              'Finished at can not be before started at',
            ]
          )
        end
      end

      response '401', 'unauthorized' do
        let(:id) { create(:game, user: user, started_at: now).id }
        let(:'X-Authorization-Token') { token.reverse }
        let(:game) do
          {
            game: {
              finished_at: now + 1.hour
            }
          }
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: ['you are not authorized to perform this action']
          )
        end
      end
    end

    get 'Retreive a game' do
      tags 'Games'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: 'X-Authorization-Token', in: :header, type: :string

      response '200', 'found' do
        let(:id) do
          create(:game,
            user: user,
            started_at: now,
            finished_at: now + 1.hour
          ).id
        end
        let(:'X-Authorization-Token') { token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            data: {
              id: a_kind_of(String),
              type: 'game',
              attributes: {
                started_at: '2019-09-01T15:05:00Z',
                finished_at: '2019-09-01T16:05:00Z'
              }
            }
          )
        end
      end

      response '404', 'not found' do
        let(:id) { 'troll' }
        let(:'X-Authorization-Token') { token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: [
              'not found',
            ]
          )
        end
      end

      response '401', 'unauthorized' do
        let(:id) do
          create(:game,
            user: user,
            started_at: now,
            finished_at: now + 1.hour
          ).id
        end
        let(:'X-Authorization-Token') { token.reverse }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to include_json(
            errors: ['you are not authorized to perform this action']
          )
        end
      end
    end
  end
end