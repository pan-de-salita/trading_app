class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_enum :status_type, %w[pending approved denied]

    create_table :statuses do |t|
      t.enum :status_type, enum_type: 'status_type', null: false, default: 'pending'
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# Usage:
# Assuming a user with ID 10, who transitions from a "pending" status to an
# "approved" status over two days.
#
# Initial State (Yesterday)
# Before any actions are taken, the statuses table might look something like
# this for the user with ID 10:
#
# ID    status_type    user_id    created_at          updated_at
# 1     pending        10         2024-06-18 00:00    2024-06-18 00:00
#
# This indicates that the user with ID 10 had a status of "pending" recorded
# on 2024-06-18.
#
# Transition to Approved (Today)
# Let's assume that on the next day, the user's status is updated to "approved".
# After this update, the statuses table might look like this:
#
# ID    status_type    user_id    created_at          updated_at
# 1     approved       10         2024-06-18 00:00    2024-06-19 12:30
#
# This entry represents the transition of the user's status from "pending" to
# "approved". The created_at and updated_at timestamps reflect when this status
# change occurred.
