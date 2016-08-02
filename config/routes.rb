Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :websites, only: [:create, :update, :destroy, :index]
  resources :tags, only: [:show, :new, :create, :index]
  resources :tag_websites, only: [:create, :destroy]
  resources :user_websites, only: [:update, :destroy]
  resources :tag_users, only: [:update, :destroy]
  root to: 'websites#index'

end
