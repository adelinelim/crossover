class Order < ActiveRecord::Base
  has_many :order_lines
  has_one :customer

  validates :customer_id, presence: true
  validates :order_no, presence: true
  validates :total, presence: true
  validates :confirm_status, presence: true
end
