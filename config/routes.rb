Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmls
  resources :websites, only: [:show, :new, :create]
  resources :tags, only: [:show, :new, :create, :index]
  root to: 'home#index'

end
