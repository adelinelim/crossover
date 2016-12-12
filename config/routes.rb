Rails.application.routes.draw do
  root "home#index"

  resources :orders
  resources :products
  resources :payments
  resources :addresses

  post "/products/:id/add_to_cart" => "cart#add_to_cart", as: "add_to_cart"
  post "/orders/:id/make_payment" => "orders#make_payment", as: "make_payment"

  devise_scope :customer do
    get "/customers/new" => "customers#new", as: "new_customer_registration"
    post "/customers(.:format)" => "customers#create" , as: "customer_registration"
  end

  devise_for :customers
  devise_for :admins
end
