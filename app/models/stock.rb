class Stock < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users, through: :transactions

  before_validate :fetch_stock_info

  def fetch_stock_info
    # Api thing
    stock_timeseries = Alphavantage::TimeSeries.search(keywords: ticker.to_s)
    stock_info = stock_timeseries.daily(outputsize: 'compact')

    update(
      company_name: BaseStocks.find(ticker: ticker.to_s).company_name,
      # most updated close price
      share_price: stock_info.time_series_daily.first[1].close
    )

    company_list[1..-1].each_with_object(Hash.new(0)) do |row, hash|
      hash[row[0]] = {
        name: row[1],
        exchange: row[2],
        asset_type: row[3],
        ipo_date: row[4],
        delisting_date: row[5],
        status: row[6]
      }
    end
  end
end
