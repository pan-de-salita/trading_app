class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Associations
  has_one :status, dependent: :destroy
  accepts_nested_attributes_for :status
  has_many :transactions
  has_many :stocks, through: :transactions

  # Status configs
  before_create :initialize_trader_status
  before_create :initialize_admin_status

  # Roles per user
  # To view all roles, use User.role.keys
  enum :role, {
    admin: 'admin',
    trader: 'trader'
  }, default: 'trader'

  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 256 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  # NOTE: already builtin validation via enums
  # validates :role, inclusion: {
  #   in: %w[admin trader],
  #   message: '<value>s is not a valid role'
  # }

  # Devise override adding custom logic for authentication. A user may
  # be authenticated when:
  # - They are an admin
  # - Their account was confirmed via email (has a created_at? attr)
  def active_for_authentication?
    super && (admin? || confirmed_at?)
  end

  def inactive_message
    # Messages can be found in devise.en.yml
    status.approved? ? :signed_up : :signed_up_but_inactive
  end

  private

  def initialize_trader_status
    return unless trader?

    if admin_created?
      build_status(status_type: 'approved')
    else
      build_status(status_type: 'pending')
    end
  end

  def initialize_admin_status
    return unless admin?

    build_status(status_type: 'approved')
  end

  def update_trader_status_to_approved
    status.update(status_type: 'approved')
  end

  def update_trader_status_to_denied
    status.update(status_type: 'denied')
  end
end
