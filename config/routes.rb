Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'business', to: 'pages#business'
  get 'income', to: 'pages#income'
  get 'calendar', to: 'pages#calendar'
  resources :yachts do
    resources :bookings, only:[:new,:create]
  end
  resources :chatrooms, only: [:show,:index,:new,:create] do
    resources :messages, only: :create
  end
  get 'my_yachts', to: 'yachts#my_yachts'
  get 'your_crew', to: 'yachts#your_crew'
  patch 'yachts/:id/update_location', to: 'yachts#update_location'
  get 'tracker', to: 'yachts#tracker'
  get 'tracker_move', to: 'yachts#tracker_move'
  resources :bookings ,only: [:edit,:destroy,:update,:index]
end
