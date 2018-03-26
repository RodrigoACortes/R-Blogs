Rails.application.routes.draw do

  root 'users#new'

  resources :blogs do
    resources :comments
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  resources :users

  get '*path' => redirect('/')
end
