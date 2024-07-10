# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  status_type :enum             default("pending"), not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Status < ApplicationRecord
  # Associations
  belongs_to :user

  # To view all of the status_types, use Status.status_type.keys
  enum :status_type, {
    pending: 'pending',
    approved: 'approved',
    denied: 'denied'
  }, default: 'pending'
end
