Rails.application.routes.draw do
  get 'rooms/show'
  devise_for :users, controllers: {   registrations: 'users/registrations', sessions: 'users/sessions' }
  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end

  root to: 'home#top'
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update] do
  	member do
      get :following, :followers
    end
  end
  resources :rooms
  
  resources :relationships, only: [:create, :destroy]

  resources :searchs, only: [:index]

end