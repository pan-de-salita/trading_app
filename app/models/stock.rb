class Stock < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users, through: :transactions

  def self.ransackable_attributes(auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(auth_object = nil)
    authorizable_ransackable_associations
  end

end

