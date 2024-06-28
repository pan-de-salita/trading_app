class Stock < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users, through: :transactions

  def self.ransackable_attributes(_auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(_auth_object = nil)
    authorizable_ransackable_associations
  end

  def set_or_fetch_stock_data
    return unless data.nil? || updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')

    fetch_stock_information(:data)
  end

  def set_or_fetch_stock_news
    return unless news.nil? || updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')

    fetch_stock_information(:news)
  end

  def fetch_stock_information(attr)
    if attr == :data
      response = Alphavantage::TimeSeries.new(symbol: ticker).daily(outputsize: 'compact')
    elsif attr == :news
      response = Alphavantage::Client.new(function: 'NEWS_SENTIMENT', tickers: ticker).json
    end

    update(attr: (attr == :data ? response.to_json : response.to_json.feed)) unless response['information']
  end
end
