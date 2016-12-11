class CustomersController < ApplicationController
  include DeviseHelper

  protect_from_forgery

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @customer }
      else
        binding.pry
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:firstname, :lastname, :email, :password, :encrypted_password)
    end
end
