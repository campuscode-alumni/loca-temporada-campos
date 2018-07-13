Rails.application.routes.draw do
  devise_for :users
  root to: 'properties#index'
  resources :properties, only: [:show, :new, :create]
  resources :property_types, only: [:show, :new, :create]
  resources :regions, only: [:show, :new, :create]
  resources :proposals, only: [:index]
end
