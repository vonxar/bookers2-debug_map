Rails.application.routes.draw do
  root 'home#top'
  devise_for :users
  get 'home/about'
  resources :users,only: [:show,:index,:edit,:update] do
     member do
       get :following, :followers
     end
   end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments,only: [:create,:destroy]
  end
  resources :relationships, only: [:create,:destroy]
  
   get '/search' ,to: 'searchs#search'
  
  
end