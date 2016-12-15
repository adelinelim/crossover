class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.string :session_secret_key

      t.timestamps null: false
    end
  end
end
