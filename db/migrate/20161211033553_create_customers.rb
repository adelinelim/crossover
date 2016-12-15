class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :session_secret_key

      t.timestamps null: false
    end
  end
end
