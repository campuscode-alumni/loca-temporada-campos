Rails.application.routes.draw do
  devise_for :realtors
  devise_for :users
  root to: 'properties#index'
  resources :properties, only: [:show, :new, :create, :edit, :update] do
    resources :proposals, only: [:new, :create]
  end
  resources :property_types, only: [:show, :new, :create, :edit, :update]
  resources :regions, only: [:show, :new, :create, :edit, :update]
  resources :proposals, only: [:index]
  resources :realtors, only: [:index]
end
