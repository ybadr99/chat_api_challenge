require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :applications, param: :token, only: [:index, :create, :update, :show, :destroy] do
      resources :chats, param: :number, only: [:create, :show, :index, :destroy] do
        resources :messages, param: :number, only: [:create, :show, :index, :update, :destroy]
      end
  end

end
