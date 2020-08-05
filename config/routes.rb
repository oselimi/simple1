Rails.application.routes.draw do
  get 'signup', to: 'users#new'
  root to: 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  get "signin", to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
