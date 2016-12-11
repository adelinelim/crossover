class Order < ActiveRecord::Base
  has_many :order_lines
  has_one :customer

  validates :customer_id, presence: true
  validates :order_no, presence: true, uniqueness: true
  validates :total, presence: true, numericality: true
end
