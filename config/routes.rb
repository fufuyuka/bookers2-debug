Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
    devise_for :users

  resources :users, only: [:index,:show,:edit,:update]
  
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end
  
  resources :user do
    resource :relationships, only: [:create,:destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :rooms, only: [:show]
  resources :chats, only: [:index,:create]
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
