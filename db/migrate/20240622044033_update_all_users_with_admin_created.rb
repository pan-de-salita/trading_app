class UpdateAllUsersWithAdminCreated < ActiveRecord::Migration[7.1]
  def change
    User.update_all(admin_created: false)
  end
end
