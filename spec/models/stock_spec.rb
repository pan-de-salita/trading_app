require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:google) { create(:stock) }

  it 'fetches data and news from Alphavantage' do
    expect(google.data).to eq(nil)
    expect(google.news).to eq(nil)

    google.set_or_fetch_from_alphavantage
    expect(google.data).to_not eq(nil)
    expect(google.news).to_not eq(nil)
  end

  # write test for self.with_positive_total_shares, which accepts
  # user_transactions
end
