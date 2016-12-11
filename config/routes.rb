Rails.application.routes.draw do
  root "home#index"

  resources :orders
  resources :products

  devise_scope :customer do
    get "/customers/sign_up" => "customers#sign_up", as: "new_customer_registration"
  end

  devise_for :customers
end
