require 'rails_helper'

RSpec.describe Status, type: :model do
  it 'should be of an acceptable status' do
    acceptable_statuses = %w[pending approved denied]
    acceptable_statuses.each do |_acceptable_status|
      expect(FactoryBot.build(:user).build_status.valid?).to eq(true)
    end
  end
end
