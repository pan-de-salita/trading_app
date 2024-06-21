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

    # NOTE: build_status does not create a Status instance; it only initializes it
    init_status = build_status(status_type: 'pending')
    init_status.save if init_status.valid?
  end

  def update_trader_status_to_approved
    status.update(status_type: 'approved')
  end

  def update_trader_status_to_denied
    status.update(status_type: 'denied')
  end
end
