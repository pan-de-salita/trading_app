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
      current_price: stock_info.time_series_daily.first[1].close
    )
  end
end