Rails.application.routes.draw do
  root to: 'home#home'

  resources :stores do
    post :select, on: :member
  end
  resources :albums
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
