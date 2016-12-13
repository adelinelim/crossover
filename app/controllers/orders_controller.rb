class OrdersController < ApplicationController

  STATUS_OK = "ok"

  before_action :authorize_customer!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :make_payment]

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order_lines = @order.order_lines
  end

  def edit
    @order_lines = @order.order_lines
    if @order.confirm_status
      redirect_to orders_path, alert: "Cannot edit an order that has already confirmed"
    end
  end

  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    update_success = update_order_line_quantity
    @order.update(total: Services::CalculateOrder.calculate_order_total(@order))

    respond_to do |format|
      if update_success.include? false
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def make_payment
    response = Services::PaymentGateway.process_payment
    if response == STATUS_OK
      if @order.update(confirm_status: true)
        redirect_to orders_path, notice: "Order no #{@order.order_no} is confirmed."
      else
        redirect_to orders_path, alert: "Error - cannot make payment to the order no #{@order.order_no}"
      end
    elsif response == "connection_failed"
      render_payment_connection_error
    else
      redirect_to orders_path, alert: "Error - with payment"
    end
  end

  private

  def get_order_line_quantity_params_keys
    params.keys.select do |key|
      key =~ /^quantity_*/
    end
  end

  def order_lines_ids_and_quantity_pair
    Hash[
      get_order_line_quantity_params_keys.map do |key|
        [key.split("_")[-1], params[key]]
      end
    ]
  end

  def update_order_line_quantity
    update_success = []
    order_lines_ids_and_quantity_pair.each do |id, quantity|
      ord_line = OrderLine.find(id)
      total_price = quantity.to_f * ord_line.unit_price
      if ord_line.update_attributes(quantity: quantity.to_i, total_price: total_price)
        update_success << true
      else
        update_success << false
      end
    end
    update_success
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:order_no, :customer_id, :total, :confirm_status)
  end
end
