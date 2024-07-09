require 'rails_helper'

RSpec.describe Status, type: :model do
  it 'should be of an acceptable status' do
    acceptable_statuses = %w[pending approved denied]
    test_statuses = acceptable_statuses + %w[awaiting invited]

    test_statuses.each do |status|
      if acceptable_statuses.include?(status)
        expect(build(:user).build_status(status_type: status)).to be_valid
        next
      end

      begin
        expect(build(:user).build_status(status_type: status)).to_not be_valid
      rescue ArgumentError => e
        puts "Caught error: #{e.message}"
      end
    end
  end

  it 'should belong to a User' do
    expect(build(:status, :with_user)).to be_valid
    expect(build(:status, :without_user)).to_not be_valid
  end
end
