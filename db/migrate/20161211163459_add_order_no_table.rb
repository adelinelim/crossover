class AddOrderNoTable < ActiveRecord::Migration
  def change
    create_table :order_nos
  end
end
