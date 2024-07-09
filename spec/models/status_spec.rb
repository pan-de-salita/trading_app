require 'rails_helper'

RSpec.describe Status, type: :model do
  it 'should be of an acceptable status' do
    acceptable_statuses = %w[pending approved denied]
    test_statuses = [..acceptable_statuses, 'awaiting', 'invited']

    test_statuses.each do |status|
      expect(build(:user).build_status(status_type: status)).to be_valid if acceptable_statuses.include?(status)

      begin
        expect(build(:user).build_status(status_type: status)).to_not be_valid
      rescue ArgumentError => e
        puts "Caught error: #{e.message}"
      end
    end
  end
end
