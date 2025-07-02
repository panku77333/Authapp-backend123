# config/routes.rb
Rails.application.routes.draw do
  post '/auth/login', to: 'auth#login'
  post '/auth/register', to: 'auth#register'
  get '/auth/me', to: 'auth#me'

  resources :users, only: [:index, :show, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end
