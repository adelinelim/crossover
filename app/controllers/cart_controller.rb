class CartController < ApplicationController
  include AuthHelper

  before_action :authorize_customer!, only: :add_to_cart

  def add_to_cart
    binding.pry
    # generate_order
    redirect_to :back, notice: "Product was successfully added to the cart."
  end

  private

  def generate_order_no
    order_no = OrderNo.create
    order_id = sprintf "%07d", order_no.id
    "O#{order_id}"
  end

  def generate_order
    existing_order = has_existing_order?
    if existing_order
      existing_order.total = update_order_total
      existing_order.save
    else
      new_order = Order.new
      new_order.order_no = generate_order_no
      new_order.customer_id = current_customer.id
      new_order.total = update_order_total
      new_order.confirm_status = false
      new_order.save
    end
  end

  def has_existing_order?
    Order.find(customer_id: current_customer.id, confirm_status: false)
  end

  def update_order_total
    # TODO:
    0
  end

  def product_params
    params.require(:product).permit(:name, :description, :image_url, :price, :status)
  end

  def order_params
    params.require(:order).permit(:order_no, :customer_id, :total, :confirm_status)
  end

  def order_line_params
    params.require(:order_line).permit(:order_id, :product_id, :quantity, :unit_price, :total_price)
  end
end
