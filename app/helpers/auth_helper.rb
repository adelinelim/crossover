module AuthHelper
  def authorize_admin!
    render_403 unless current_admin
  end

  def authorize_customer!
    render_403 unless current_customer
  end
end
