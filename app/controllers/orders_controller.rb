class OrdersController < ApplicationController

  before_action :authorize_customer!
  before_action :set_order, only: [:show, :edit, :update, :destroy, :make_payment]

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order_lines = @order.order_lines
  end

  def new
    @order = Order.new
  end

  def edit
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
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
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
    # http://localhost:5000/payment/create
    # binding.pry
    response = Services::PaymentGateway.process_payment
    binding.pry
    if response == "ok"
      # if @order.update(confirm_status: true)
      #   redirect_to orders_path, notice: "Order no #{@order.order_no} is confirmed."
      # else
        redirect_to orders_path, alert: "Error - cannot confirm the order no #{@order.order_no}"
      # end
    elsif response == "connection_failed"
      render_payment_connection_error
    else
      redirect_to orders_path, alert: "Error - with payment"
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:order_no, :customer_id, :total, :confirm_status)
    end
end
