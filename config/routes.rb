Rails.application.routes.draw do

  # Set Project Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/help',        to: 'static_pages#help'
  get '/about',       to: 'static_pages#about'
  get '/contact',     to: 'static_pages#contact'
  get '/subscribe',   to: 'static_pages#subscribe'

  # Set Babies Paths #
  get    '/signup',   to: 'babies#new'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  # Set Project CHat Rooms #
  get '/text',        to: 'rooms#show'


  # Set Project Resources #
  resources :babies
  resources :microposts,          only: [:create, :destroy]

  # Set Mounting for Chat Features #
  mount ActionCable.server => '/cable'

end
