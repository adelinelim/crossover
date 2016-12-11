class CustomersController < ApplicationController
  include CustomerHelper

  protect_from_forgery

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to root_path
      # format.html { redirect_to root_path, notice: 'Customer was successfully created.' }
    else
      render :new
      # format.json { render json: @customer.errors, status: :unprocessable_entity }
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:firstname, :lastname, :email, :password, :encrypted_password)
    end
end
