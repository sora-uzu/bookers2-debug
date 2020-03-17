Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :books
  root to: 'home#top'
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update]
end