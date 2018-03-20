require 'sidekiq/web'

Rails.application.routes.draw do
  root 'machines#index'
  resources :machines, only: [:index, :show]
  resources :stats, only: :index
  namespace :api, defaults: {format: :json} do
    resources :machines do
      put :update_template, on: :member
      put :reboot, on: :member
      post :upload_config, on: :collection
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
