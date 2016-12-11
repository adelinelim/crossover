class CartController < ApplicationController
  include AuthHelper

  before_action :authorize_customer!, only: :add_to_cart

  def add_to_cart
    if generate_order_and_order_line
      redirect_to :back, notice: "Product was successfully added to the cart."
    else
      redirect_to :back, alert: "Error - Cannot add to cart."
    end
  end

  private

  def get_product
    Product.find(params[:id])
  end

  def generate_order_no
    order_no = OrderNo.create
    order_id = sprintf "%07d", order_no.id
    "O#{order_id}"
  end

  def generate_order_and_order_line
    binding.pry
    success_save = false
    existing_order = get_order
    if existing_order
      order_line = create_order_line(existing_order)
      existing_order.total = calculate_order_total(existing_order)
      success_save = order_line.valid?
      existing_order.save
    else
      saved_order = create_new_order
      order_line = create_order_line(saved_order)
      success_save = order_line.valid?
      saved_order.total = calculate_order_total(saved_order)
      saved_order.save
    end
    success_save
  end

  def create_new_order
    new_order = Order.new
    new_order.order_no = generate_order_no
    new_order.total = 0
    new_order.customer_id = current_customer.id
    new_order.confirm_status = false
    new_order.save
    new_order
  end

  def create_order_line(order)
    binding.pry
    product = get_product
    existing_order_line = get_order_line(order.id, product.id)
    if existing_order_line
      existing_order_line.quantity += 1
      existing_order_line.unit_price = product.price
      existing_order_line.total_price = calculate_order_line_total_price(existing_order_line)
      existing_order_line.save
      existing_order_line
    else
      order_line = OrderLine.new
      order_line.order_id = order.id
      order_line.product_id = product.id
      order_line.quantity = 1
      order_line.unit_price = product.price
      order_line.total_price = calculate_order_line_total_price(order_line)
      order_line.save
      order_line
    end
  end

  def calculate_order_line_total_price(order)
    order.quantity * order.unit_price
  end

  def get_order_line(order_id, product_id)
    OrderLine.where(order_id: order_id, product_id: product_id).first
  end

  def get_order
    Order.where(customer_id: current_customer.id, confirm_status: false).first
  end

  def calculate_order_total(order)
    order.try(:order_lines).try(:sum, :total_price) || 0
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
