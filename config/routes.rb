Rails.application.routes.draw do
  root 'players#index'
  get 'players/ranking'
  resources :players
  resources :matches
end
