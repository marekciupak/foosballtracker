Rails.application.routes.draw do
  devise_for :users
  root 'players#index'
  resources :players
  resources :matches, only: [:index, :new, :create]
end
