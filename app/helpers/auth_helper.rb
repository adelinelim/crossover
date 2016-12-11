module AuthHelper
  def authorize_admin!
    render_403 unless current_admin
  end
end
