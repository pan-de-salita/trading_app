class Stock < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users, through: :transactions

  def self.ransackable_attributes(_auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(_auth_object = nil)
    authorizable_ransackable_associations
  end

  def set_of_fetch_from_alphavantage
    set_or_fetch_stock_data
    set_or_fetch_stock_news
  end

  def set_or_fetch_stock_data
    return unless data.nil? || updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')

    stock_timeseries = Alphavantage::TimeSeries.new(symbol: ticker).daily(outputsize: 'compact')
    update(data: stock_timeseries.to_json) unless stock_timeseries.information
  end

  def set_or_fetch_stock_news
    return unless news.nil? || updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')

    stock_news = Alphavantage::Client.new(function: 'NEWS_SENTIMENT', tickers: ticker).json
    update(news: stock_news.feed.to_json) unless stock_news.information
  end
end
