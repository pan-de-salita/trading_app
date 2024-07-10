# == Schema Information
#
# Table name: stocks
#
#  id           :bigint           not null, primary key
#  ticker       :string
#  company_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  data         :string
#  news         :string
#  price        :decimal(, )
#  open         :decimal(, )
#  high         :decimal(, )
#  low          :decimal(, )
#  volume       :bigint
#
require 'rails_helper'

RSpec.describe Stock, type: :model do
  let!(:google) { create(:stock) }

  it 'fetches data and news from Alphavantage' do
    expect(google.data).to eq(nil)
    expect(google.news).to eq(nil)

    response = google.set_or_fetch_from_alphavantage
    expect(google.data).to_not eq(nil) unless response.nil?
    expect(google.news).to_not eq(nil) unless response.nil?
  end

  # write test for self.with_positive_total_shares, which accepts
  # user_transactions
end
