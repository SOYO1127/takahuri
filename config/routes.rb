Rails.application.routes.draw do
  get 'rooms/show'
  get 'users/index'
  get 'users/show'
  get 'posts/question' => 'posts#question'
  devise_for :users
  resources :users, only: [:show] # ユーザーマイページへのルーティング
  resources :users, :only => [:index, :show]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  
  root 'posts#index'
end
