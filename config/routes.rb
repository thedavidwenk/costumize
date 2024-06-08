Rails.application.routes.draw do
  get 'users/index'
  root to: "costumes#home"

  devise_for :users

  resources :costumes do
    resources :bookings, only: [:new, :create, :index]
    member do
      delete :remove_photo
    end
  end

  resources :bookings, only: [:show, :destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end
