class ApplicationController < ActionController::Base
  include AuthHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_403
    render file: "#{Rails.root}/public/403",
           status: 403,
           layout: false,
           formats: [:html]
  end
end
