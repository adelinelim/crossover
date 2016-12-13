class Product < ActiveRecord::Base
  belongs_to :order_line

  validates :name, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :price, presence: true, numericality: true
end
