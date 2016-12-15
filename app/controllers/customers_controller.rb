class CustomersController < ApplicationController
  include CustomerHelper

  before_action :verify_customer, except: [:sign_in, :new, :create]

  # def verify_user
  #   found_user = Customer.where(session_secret_key: session[:session_secret_key])
  #   if found_user
  #     @current_user = found_user
  #   else
  #     raise "invalid"
  #   end
  # end
  #
  # def user_signed_in?
  #   @current_user.blank?
  # end

  def sign_in
    @customer = Customer.new
  end

  def login
    binding.pry
    found_customer = Customer.where(email: params[:email])
    if found_customer.password == params[:password]
      uuid = SecureRandom.uuid
      found_customer.session_secret_key = uuid
      session[:session_secret_key] = uuid
      found_customer.save
      redirect_to root_path
    else
      render :login, alert: "Invalid user"
    end
  end

  def logout
    session[:session_secret_key] = nil
    current_user.session_secret_key = nil
    current_user.save
    redirect_to root_path
  end

  # def session_id
  #   session[:session_secret_key] = 12312332429358234519482347
  #   render json: session
  # end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.password = params[:password]

    respond_to do |format|
      if @customer.save
        format.html { redirect_to root_path, notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :email, :password)
  end
end
