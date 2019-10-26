Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#top'
  get 'home/about' => 'home#about'

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:new, :create, :edit, :update, :index, :show, :destroy]
end
