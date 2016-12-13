class CustomersController < ApplicationController
  include CustomerHelper

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to root_path, notice: "Customer was successfully created."
    else
      render :new
    end
  end

  private
    def customer_params
      params.require(:customer).permit(
        :firstname, :lastname, :email, :password, :encrypted_password
      )
    end
end
