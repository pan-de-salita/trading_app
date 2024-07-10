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
class Stock < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :users, through: :transactions

  def self.ransackable_attributes(_auth_object = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(_auth_object = nil)
    authorizable_ransackable_associations
  end

  def self.with_positive_total_shares(user_transactions)
    user_transactions.group_by(&:stock_id).each_with_object([]) do |(stock_id, transactions), arr|
      arr << Stock.find(stock_id) if Transaction.total_shares(transactions).positive?
    end
  end

  def set_or_fetch_from_alphavantage
    set_or_fetch_stock_data
    set_or_fetch_stock_news
  end

  def set_or_fetch_stock_data
    # Prevent calling when the following are true:
    # - Stock has data
    # - Stock's last update is the same as current date
    return if data.present? &&
              JSON.parse(data)['meta_data']['last_refreshed'] == DateTime.now.strftime('%Y-%m-%d')

    stock_timeseries = Alphavantage::TimeSeries.new(symbol: ticker).daily(outputsize: 'compact')
    return if stock_timeseries.information

    update_with_fetched_data(stock_timeseries)
  end

  def update_with_fetched_data(fetched_data)
    update(
      price: fetched_data['time_series_daily'].first[1]['close'].to_f,
      open: fetched_data['time_series_daily'].first[1]['open'].to_f,
      high: fetched_data['time_series_daily'].first[1]['high'].to_f,
      low: fetched_data['time_series_daily'].first[1]['low'].to_f,
      volume: BigDecimal(fetched_data['time_series_daily'].first[1]['volume']),
      data: fetched_data.to_json
    )
  end

  def set_or_fetch_stock_news
    # Prevent calling when the following are true:
    # - Stock has news
    # - Stock's last update is the same as current date
    return if news.present? &&
              DateTime.strptime(JSON.parse(news).first['time_published'],
                                '%Y%m%dT%H%M%S').strftime('%Y-%m-%d') == DateTime.now.strftime('%Y-%m-%d')

    stock_news = Alphavantage::Client.new(function: 'NEWS_SENTIMENT', tickers: ticker).json
    update(news: stock_news.feed.to_json) unless stock_news.information
  end
end
