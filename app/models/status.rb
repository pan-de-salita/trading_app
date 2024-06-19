class Status < ApplicationRecord
  belongs_to :user

  enum :status_types, {
    pending: 'pending',
    approved: 'approved',
    denied: 'denied'
  }, default: 'pending'
end
