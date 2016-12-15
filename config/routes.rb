Rails.application.routes.draw do
  root "home#index"

  resources :orders, except: :new
  resources :products
  resources :payments
  resources :addresses

  resources :admins

  # get '/lala', to: 'customers#session_id'

  get "/customers/sign_in" => "customers#sign_in", as: "sign_in_customer"
  post "/customers/login" => "customers#login", as: "login_customer"
  post "/customers/logout" => "customers#logout", as: "logout_customer"
  resources :customers, only: [:new, :create]

  post "/products/:id/add_to_cart" => "cart#add_to_cart", as: "add_to_cart"
  post "/orders/:id/make_payment" => "orders#make_payment", as: "make_payment"
end
