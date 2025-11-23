Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)

  root "products#index"

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post "add/:product_id", to: "carts#add", as: :add
    patch "update/:product_id", to: "carts#update", as: :update
    delete "remove/:product_id", to: "carts#remove", as: :remove
  end

  resources :orders, only: [:index, :show, :create]
  get "/checkout", to: "checkout#new"
  post "/checkout", to: "checkout#create"

  get "/pages/:title", to: "pages#show", as: :page
end
