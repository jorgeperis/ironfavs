Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmls
  resources :websites, only: [:create, :update, :destroy]
  resources :tags, only: [:show, :new, :create, :index]
  resources :tag_websites, only: [:create, :destroy]
  resources :user_websites, only: [:update, :destroy]
  resources :tag_users, only: [:update, :destroy]
  root to: 'home#index'
  get '/search', to: 'home#search'
  post '/search_by_tags', to: 'home#search_by_tags'
  post '/search_type', to: 'home#search_type'

end
