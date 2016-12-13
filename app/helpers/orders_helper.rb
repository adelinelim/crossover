module OrdersHelper
  def order_confirmation_status(order)
    order.confirm_status ? "Confirmed" : "Pending"
  end
end
