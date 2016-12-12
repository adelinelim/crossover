class Payment < ActiveRecord::Base
  has_one :payment
  belongs_to :order
  has_one :address
end
