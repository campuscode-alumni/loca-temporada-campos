Rails.application.routes.draw do
  devise_for :realtors
  devise_for :users
  root to: 'properties#index'
  resources :properties, only: [:show, :new, :create, :edit, :update] do
    resources :proposals, only: [:new, :create]
  end
  resources :proposals, only: [:index, :show] do
    get 'approve', on: :member
  end
  resources :property_types, only: [:show, :new, :create, :edit, :update]
  resources :regions, only: [:show, :new, :create, :edit, :update]
  resources :proposals, only: [:index, :show]
  resources :realtors, only: [:index]
end
