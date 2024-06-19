class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_one :status, dependent: :destroy
  accepts_nested_attributes_for :status

  # To view all roles, use User.role.keys
  enum :role, {
    admin: 'admin',
    trader: 'trader'
  }, default: 'trader'

  before_create :set_trader_status_as_pending

  private

  def set_trader_status_as_pending
    return unless trader?

    build_status(status_type: 'pending')
  end
end
