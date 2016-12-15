class ApplicationController < ActionController::Base
  include AuthHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_reader :current_customer

  def render_403
    render file: "#{Rails.root}/public/403",
           status: 403,
           layout: false,
           formats: [:html]
  end

  def render_payment_connection_error
    render file: "#{Rails.root}/public/connection_failed",
           status: 404,
           layout: false,
           formats: [:html]
  end

  def render_404
    render file: "#{Rails.root}/public/404",
           status: 404,
           layout: false,
           formats: [:html]
  end

  def verify_customer
    binding.pry
    found_user = Customer.where(session_secret_key: session[:session_secret_key])
    if found_user
      @current_customer = found_user
    else
      raise "invalid user"
    end
  end
  helper_method :verify_customer

  def customer_signed_in?
    @current_customer.present?
  end
  helper_method :customer_signed_in?

  def admin_signed_in?
    true
  end
  helper_method :admin_signed_in?
end
