Rails.application.routes.draw do
  resource :registrations, only: %i[new create]
  resource :sessions, only: %i[new create destroy]
  resources :users, only: %i[index show] do
    resource :follows, only: %i[create destroy]
    get :favorites, on: :member
    get :follows, on: :member
    get :followers, on: :member
  end
  resources :tweets do
    resource :favorites, only: %i[create destroy]
    get :timeline, on: :collection
  end
  resources :rooms, only: %i[new create show index]

  root to: 'registrations#new'

  mount ActionCable.server => '/cable'
end
