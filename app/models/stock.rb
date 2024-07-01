class Stock < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users, through: :transactions

  def self.ransackable_attributes(_auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(_auth_object = nil)
    authorizable_ransackable_associations
  end

  def set_or_fetch_from_alphavantage
    set_or_fetch_stock_data
    set_or_fetch_stock_news
  end

  def set_or_fetch_stock_data
    p 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    p 'trying to fetch data'

    # NOTE: problematic clause:
    unless data.nil? || updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')
      p 'not fetching data'
      p 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'

    end

    stock_timeseries = Alphavantage::TimeSeries.new(symbol: ticker).daily(outputsize: 'compact')
    return if stock_timeseries.information

    p 'fetched data; updating stock'
    p 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    update(
      price: stock_timeseries['time_series_daily'].first[1]['close'].to_f,
      open: stock_timeseries['time_series_daily'].first[1]['open'].to_f,
      high: stock_timeseries['time_series_daily'].first[1]['high'].to_f,
      low: stock_timeseries['time_series_daily'].first[1]['low'].to_f,
      volume: BigDecimal(stock_timeseries['time_series_daily'].first[1]['volume']),
      data: stock_timeseries.to_json
    )
  end

  def set_or_fetch_stock_news
    return unless news.nil? || updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')

    stock_news = Alphavantage::Client.new(function: 'NEWS_SENTIMENT', tickers: ticker).json
    update(news: stock_news.feed.to_json) unless stock_news.information
  end
end
