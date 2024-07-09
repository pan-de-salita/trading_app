require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:trader) { create(:user, :trader) }
  let!(:admin) { create(:user, :admin) }

  it 'should have a unique email address' do
    trader_using_existing_email = build(:user, email: trader.email)
    expect(trader_using_existing_email).to_not be_valid
    expect(trader_using_existing_email.errors.full_messages).to include('Email has already been taken')
  end

  it 'should having matching password and password_confirmation' do
    trader_with_mismatching_passwords = build(:user, password: 'foobar', password_confirmation: 'barfoo')
    expect(trader_with_mismatching_passwords).to_not be_valid
    expect(trader_with_mismatching_passwords.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it 'should carry only acceptable roles' do
    accepted_roles = %w[admin trader]
    test_roles = [..accepted_roles, 'frontend_dev', 'backend_dev']

    test_roles.each_with_index do |role, idx|
      expect(build(:user, email: "#{role}_#{idx}@mail.com", role:)).to be_valid if accepted_roles.include?(role)

      begin
        expect(build(:user, email: "unacceptable_#{idx}@mail.com", role:)).to_not be_valid
      rescue ArgumentError => e
        puts "Caught error: #{e.message}"
      end
    end
  end

  it "should be of role 'trader' if no role was specified upon creation" do
    trader_with_no_role_specified = build(:user, email: 'user@mail.com')
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
    trader_created_by_admin = create(:user, :trader, :admin_created)
    expect(trader_created_by_admin.status.approved?).to eq(true)
  end

  it "should automatically have 'approved' status if created as an admin" do
    expect(admin.status.approved?).to eq(true)
  end

  it 'should not be active for authentication if not admin or not confirmed' do
    expect(trader.admin?).to eq(false)
    expect(trader.confirmed_at?).to eq(false)
    expect(trader.active_for_authentication?).to eq(false)
  end

  it 'should be active for authentication if carries a confirmed_at attribute' do
    confirmed_trader = create(:user, :trader, :confirmed_email)
    expect(confirmed_trader.admin?).to eq(false)
    expect(confirmed_trader.confirmed_at?).to eq(true)
    expect(confirmed_trader.active_for_authentication?).to eq(true)
  end

  it 'should be active for authentication if an admin' do
    expect(admin.admin?).to eq(true)
    expect(admin.confirmed_at?).to eq(false)
    expect(admin.active_for_authentication?).to eq(true)
  end
end
