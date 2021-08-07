Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments,only:[:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index]do
    member do 
      get :following, :followers
    end 
    resource :relationships, only:[:create, :destroy]
  end 
  get 'home/about', to: "homes#about"
  get '/search', to: 'searches#search'
end
