class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true, null: false
      t.string :order_no, null: false
      t.decimal :total, precision: 10, scale: 2, null: false
      t.boolean :confirm_status

      t.timestamps null: false
    end
  end
end
