Rails.application.routes.draw do
  resources :recipes
  resources :users
  post '/signup', to: 'users#create'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/me', to: 'users#show'
  get '/recipes', to: 'recipes#index'
  post '/recipes', to: 'recipes#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
