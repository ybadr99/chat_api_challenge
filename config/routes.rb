require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :applications, param: :token, only: [:create, :update, :show] do
    resources :chats, param: :number, only: [:create, :show, :index]
  end

end
