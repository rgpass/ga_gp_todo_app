Rails.application.routes.draw do

  match '/home',  to: 'static_pages#home',  via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/help',  to: 'static_pages#help',  via: 'get'

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'

  resources :tasks
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create, :destroy]
end
