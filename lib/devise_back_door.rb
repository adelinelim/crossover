# Allows tests to sign in a user by passing the user or it's id in the
# `as` parameters.
#   example:
#     visit campaign_path(as: campaign.user)
class DeviseBackDoor
  def initialize(app)
    @app = app
  end

  def call(env)
    sign_in_through_the_back_door(env)
    @app.call(env)
  end

  private

  def sign_in_through_the_back_door(env)
    params = Rack::Utils.parse_query(env["QUERY_STRING"])
    customer_id = params["as"]

    if customer_id.present?
      env["warden"].set_user Customer.find(customer_id), scope: :customer
    end
  end
end
