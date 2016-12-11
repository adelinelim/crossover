json.extract! customer, :id, :firstname, :lastname, :email, :password, :created_at, :updated_at
json.url customer_url(customer, format: :json)