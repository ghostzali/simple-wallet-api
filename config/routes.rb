Rails.application.routes.draw do

  resources :sessions, only: [:create, :destroy]
  resources :transactions, only: [:create]
  resources :stocks, only: [] do
    collection do
      get :price
      get :prices
      get :price_all
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
