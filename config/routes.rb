Rails.application.routes.draw do

  # Set Project Root Path #
  root 'static_pages#home'

  # Set Static Page Paths #
  get '/help',     to: 'static_pages#help'
  get '/about',    to: 'static_pages#about'
  get '/contact',  to: 'static_pages#contact'
end
