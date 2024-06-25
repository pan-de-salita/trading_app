class AddAdminCreatedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin_created, :boolean, default: false
  end
end
