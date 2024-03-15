Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")


  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post 'login', to: 'sessions#create'
      post 'signup', to: 'users#create'
      delete 'logout', to: 'sessions#destroy'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :blogs, only: [:index]
    end
  end
  
  root 'sessions#new'
  resources :blogs
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
