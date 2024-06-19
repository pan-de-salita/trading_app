class Status < ApplicationRecord
  belongs_to :user

  # to view all of the status_types, use Status.status_type.keys
  enum :status_type, {
    pending: 'pending',
    approved: 'approved',
    denied: 'denied'
  }, default: 'pending'
end
