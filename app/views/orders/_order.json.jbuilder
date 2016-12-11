json.extract! order, :id, :order_no, :customer_id, :total, :confirm_status, :created_at, :updated_at
json.url order_url(order, format: :json)
