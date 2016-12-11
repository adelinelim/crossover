Rails.application.routes.draw do
  root "home#index"

  resources :orders
  resources :products

  devise_scope :customer do
    get "/customers/new" => "customers#new", as: "new_customer_registration"
    post "/customers(.:format)" => "customers#create" , as: "customer_registration"
  end

  devise_for :customers
  devise_for :admins
end
