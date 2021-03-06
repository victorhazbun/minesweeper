Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resource :authentication, only: [:create]
      resources :games, only: [:show, :create, :update]
    end
  end

  resource :game, only: [:new, :show]

  get '/login', to: 'authentications#new', as: :login

  root 'pages#landing'
end
