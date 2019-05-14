module Api
  module V1
    class GamesController < ApiController
      before_action :set_game, only: [:show, :update]

      def show
        if stale?(@game)
          render json: serialize_game(@game), status: :ok
        end
      end

      def create
        game = current_user.games.build(create_game_params)
        if game.save
          render json: serialize_game(game), status: :created
        else
          render json: {
            errors: game.errors.full_messages
          }, status: :bad_request
        end
      end

      def update
        if @game.update(update_game_params)
          render json: serialize_game(@game), status: :ok
        else
          render json: {
            errors: @game.errors.full_messages
          }, status: :bad_request
        end
      end

      private

      def set_game
        @game = current_user.games.find(params[:id])
      end

      def serialize_game(game)
        GameSerializer.new(game.decorate).serialized_json
      end

      def create_game_params
        params.require(:game).permit(:started_at, :rows, :cols)
      end

      def update_game_params
        params.require(:game).permit(:finished_at)
      end
    end
  end
end