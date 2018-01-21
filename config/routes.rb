require 'sidekiq/web'

Rails.application.routes.draw do
  root 'pages#main'
  resources :machines, only: :index
  resources :stats, only: :index
  namespace :api do
    resources :machines do
      put :update_template, on: :member
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
