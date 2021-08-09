Rails.application.routes.draw do

  devise_for :users
  root "homes#top"
  get "home/about" => "homes#about"

  resources :users do
    resource :relationships, only: [:create, :destroy]
     get :follows, member: :on
     get :followers, member: :on
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
