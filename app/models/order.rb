class Order < ActiveRecord::Base
  has_many :order_lines
  has_one :customer
end
