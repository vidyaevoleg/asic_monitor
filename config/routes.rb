Rails.application.routes.draw do
  root 'pages#main'
  resources :machines, only: :index
  namespace :api do
    resources :machines do
      put :update_template, on: :member
    end
  end
end
