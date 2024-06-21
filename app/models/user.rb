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

  before_create :initialize_trader_status_as_pending
  # TODO: Evoke update_trader_status_to_approved
  # TODO: Evoke update_trader_status_to_denied

  private

  def initialize_trader_status_as_pending
    return unless trader?

    build_status(status_type: 'pending')
  end

  def update_trader_status_to_approved
    status.update(status_type: 'approved')
  end

  def update_trader_status_to_denied
    status.update(status_type: 'denied')
  end

  # def active_for_authentication?
  #   super && status.approved?
  # end
  #
  # def inactive_message
  #   # Messages can be found in devise.en.yml
  #   status.approved? ? :signed_up : :signed_up_but_inactive
  # end
end
