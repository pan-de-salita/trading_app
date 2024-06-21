class Transaction < ApplicationRecord
  belongs_to :stock, optional: true
  belongs_to :user

  # add remaining enum syntax here
end
