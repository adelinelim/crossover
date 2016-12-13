class OrderLine < ActiveRecord::Base
  belongs_to :order
  has_one :product

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :unit_price, presence: true, numericality: true
  validates :total_price, presence: true, numericality: true

  def product
    Product.find(product_id)
  end
end
