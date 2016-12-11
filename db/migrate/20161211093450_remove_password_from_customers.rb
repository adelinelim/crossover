class RemovePasswordFromCustomers < ActiveRecord::Migration
  def up
    remove_column :customers, :password
  end

  def down
    add_column :customers, :password, :string, null: false
  end
end
