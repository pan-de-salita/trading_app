require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:trader) { FactoryBot.create(:user) }

  it 'should have a unique email address' do
    trader_using_existing_email = FactoryBot.build(:user, email: trader.email)
    expect(trader_using_existing_email).to_not be_valid
    expect(trader_using_existing_email.errors.full_messages).to include('Email has already been taken')
  end

  it 'should having matching password and password_confirmation' do
    trader_with_mismatching_passwords = FactoryBot.build(
      :user,
      password: 'foobar',
      password_confirmation: 'barfoo'
    )
    expect(trader_with_mismatching_passwords).to_not be_valid
    expect(trader_with_mismatching_passwords.errors.full_messages)
      .to include("Password confirmation doesn't match Password")
  end

  it 'should only acceptable roles' do
    acceptable_roles = %w[admin trader]
    acceptable_roles.each { |accepted_role| expect(FactoryBot.build(:user, role: accepted_role)).to be_valid }
  end

  it 'should not carry unacceptable roles' do
    unacceptable_roles = %w[frontend_dev backend_dev fullstack_dev]
    unacceptable_roles.each do |unacceptable_role|
      user = User.new(role: unacceptable_role)
      expect(user).to raise_error(ArgumentError)
    rescue StandardError => e
      p "Caught error: #{e.message}"
    end
  end

  it "should be of role 'trader' if no role was specified upon creation" do
    trader_with_no_role_specified = User.new(email: 'test@mail.com', password: 'foobar',
                                             password_confirmation: 'foobar', admin_created: false)
    expect(trader_with_no_role_specified).to be_valid
    expect(trader_with_no_role_specified.role).to eq('trader')
  end

  it 'should have a nested Status attribute' do
    expect(trader.status.is_a?(Status)).to eq(true)
  end

  it "should have 'pending' status if not admin_created" do
    expect(trader.admin_created?).to eq(false)
    expect(trader.status.pending?).to eq(true)
  end

  it "should have 'approved' status if admin_created" do
    trader_created_by_admin = FactoryBot.create(:user, admin_created: true)
    expect(trader_created_by_admin.status.approved?).to eq(true)
  end

  it "should automatically have 'approved' status if created as an admin" do
    admin_user = FactoryBot.create(:user, role: 'admin')
    expect(admin_user.status.approved?).to eq(true)
  end

  it 'should not be active for authentication if not admin or not confirmed' do
    expect(trader.admin?).to eq(false)
    expect(trader.confirmed_at?).to eq(false)
    expect(trader.active_for_authentication?).to eq(false)
  end

  it 'should be active for authentication if carries a confirmed_at attribute' do
    trader.update(confirmed_at: DateTime.now)
    expect(trader.admin?).to eq(false)
    expect(trader.confirmed_at?).to eq(true)
    expect(trader.active_for_authentication?).to eq(true)
  end

  it 'should be active for authentication if an admin' do
    trader.update(role: 'admin')
    expect(trader.admin?).to eq(true)
    expect(trader.confirmed_at?).to eq(false)
    expect(trader.active_for_authentication?).to eq(true)
  end
end