Rails.application.routes.draw do

  # Set Project Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/help',     to: 'static_pages#help'
  get '/about',    to: 'static_pages#about'
  get '/contact',  to: 'static_pages#contact'

  # Set Babies Paths #
  get    '/signup',   to: 'babies#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'


  # Set Project Resources #
  resources :babies
end
