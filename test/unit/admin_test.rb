require 'test_helper'

# FactoryGirl.define do
#   factory :user, aliases: [:admin_user] do
#     password "Password123"
#     name "User Name"
#     email
#   end
# end

class AdminTest < ActiveSupport::TestCase
  it "must" do
    admin = Admin.new
    admin.password = "qwe123123"
    admin.email = "admin@admin.com"
    admin.save!
    admin.email.must_equal "admin@admin.com"
    admin.email = nil
    admin.wont_be_valid_for_attribute :email, /can't be blank/
  end
end
