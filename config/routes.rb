# frozen_string_literal: true

Rails.application.routes.draw do
  resource :registrations, only: [:new, :create]
  resource :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :show] do
    resource :follows, only: [:create, :destroy]
    get :favorites, on: :member
    get :follows, on: :member
    get :followers, on: :member
  end
  resources :tweets do
    resource :favorites, only: [:create, :destroy]
    get :timeline, on: :collection
  end
  resources :conversations do
    resources :messages
  end

  root 'registrations#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
