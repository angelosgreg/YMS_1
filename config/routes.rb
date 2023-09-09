Rails.application.routes.draw do
  get 'yacths/new'
  get 'yacths/create'
  get 'yacths/update'
  get 'yacths/edit'
  get 'yacths/destroy'
  get 'yacths/index'
  get 'yacths/show'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
