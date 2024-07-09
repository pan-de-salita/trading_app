class StocksController < ApplicationController
  before_action :check_trader_confirmed?

  def index
    @q = Stock.ransack(params[:q])
    @stocks = params[:q] ? @q.result(distinct: true) : []

    @general_news = Rails.cache.fetch('general_news', expires_in: 12.hours) do
      response = Alphavantage::Client.new(function: 'NEWS_SENTIMENT').json
      response['feed'].first(12) unless response['information']
    end
 
  end

  def show
    @stock = Stock.find(params[:id])
    @stock.set_or_fetch_from_alphavantage
    @stock_timeseries = JSON.parse(@stock.data) unless @stock.data.nil?
    @stock_news = JSON.parse(@stock.news).first(12) unless @stock.news.nil?

    @historical_data = format_stock_data(@stock_timeseries['time_series_daily']).reverse unless @stock_timeseries.nil?
    # Made sure that if nil, page will load
    if @historical_data
      @chart_data = @historical_data.each_with_object({}) do |data, hash|
        hash[data[:time]] = [data[:open], data[:close], data[:low], data[:high]]
      end
    end
    console
  end

  private

  def format_stock_data(stock_data)
    stock_data.map do |time, data|
      {
        time: Time.parse(time.to_s).strftime("%B %d, %Y"),
        open: data['open'].to_f,
        high: data['high'].to_f,
        low: data['low'].to_f,
        close: data['close'].to_f,
        volume: data['volume'].to_i
      }
    end
  end
end
