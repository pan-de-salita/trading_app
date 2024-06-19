class CreateRoleEnumForUsers < ActiveRecord::Migration[7.1]
  def change
    create_enum :role, %w[admin trader]

    change_table :users do |t|
      t.enum :role, enum_type: 'role', default: 'trader', null: false
    end
  end
end

# Usage:
# Assuming a user that is an admin:
# user.status # => 'admin'
# user.admin? # => true
# user.trader? # => false
#
# Assuming a user that is a trader:
# user.status # => 'trader'
# user.admin? # => false
# user.trader? # => true
