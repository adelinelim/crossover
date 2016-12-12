Rails.application.routes.draw do
  root "home#index"

  resources :orders
  resources :products
  resources :payments
  resources :addresses

  post "/products/:id/add_to_cart" => "cart#add_to_cart", as: "add_to_cart"
  post "/orders/:id/confirm_order" => "orders#confirm_order", as: "confirm_order"

  devise_scope :customer do
    get "/customers/new" => "customers#new", as: "new_customer_registration"
    post "/customers(.:format)" => "customers#create" , as: "customer_registration"
  end

  devise_for :customers
  devise_for :admins
end
