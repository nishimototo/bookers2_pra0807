Rails.application.routes.draw do

  devise_for :users
  root "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search"
  get "chats/:id" => "chats#show", as: "chat"

  resources :users do
    resource :relationships, only: [:create, :destroy]
     get :follows, on: :member
     get :followers, on: :member
     get :count_search, on: :member
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :chats, only: [:create]
  resources :groups
end
