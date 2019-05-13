Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resource :authentication, only: :create
      resource :registration, only: :create
    end
  end

  root 'pages#landing'
end
