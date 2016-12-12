class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :payment_state
      t.string :paypal_token
      t.string :paypal_payer_id
      t.string :paypal_identifier
      t.references :address, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
