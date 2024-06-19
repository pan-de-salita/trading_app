class Status < ApplicationRecord
  belongs_to :user

  enum :status, {
    pending: 'pending',
    approved: 'approved',
    denied: 'denied'
  }, default: 'pending'
end
