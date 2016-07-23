Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmls
get '/', to: 'prueba#index'
get '/show', to: 'prueba#show'
get '/website/new', to: 'website#new'
post '/websites', to: 'website#create'
end
