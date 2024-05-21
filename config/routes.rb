require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :applications, param: :token, only: [:create, :update, :show]
end
