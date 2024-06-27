class StocksController < ApplicationController
  before_action :set_general_news

  def index
    @q = Stock.ransack(params[:q])
    @stocks = params[:q] ? @q.result(distinct: true) : []

    # NOTE: For debugging only
    return unless params[:q]

    @search_item = params[:q][:company_name_or_ticker_cont]
  end

  def show
    @stock = Stock.find(params[:id])
    p @stock
    p @stock.ticker

    if @stock.data.nil? || @stock.updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')
      stock_timeseries = Alphavantage::TimeSeries.new(symbol: @stock.ticker).daily(outputsize: 'compact')
      @stock.update(data: stock_timeseries.to_json) unless stock_timeseries.information

      p 'STOCK'
      p @stock
      p 'STOCK'
    end

    if @stock.news.nil? || @stock.updated_at.utc.strftime('%Y-%m-%d') != DateTime.now.strftime('%Y-%m-%d')
      stock_news = Alphavantage::Client.new(function: 'NEWS_SENTIMENT', tickers: @stock.ticker).json
      @stock.update(news: stock_news.to_json) unless stock_news.information

      p 'NEWS'
      p @stock
      p 'NEWS'
    end

    @stock_timeseries = JSON.parse(@stock.data) unless @stock.data.nil?
    @stock_news = JSON.parse(@stock.news) unless @stock.news.nil?

    p 'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
    p @stock_timeseries
    p @stock_news
    p 'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
  end

  private

  def set_general_news
    general_news = Alphavantage::Client.new(function: 'NEWS_SENTIMENT').json
    @general_news = general_news.information ? general_news.feed : nil
  end
end
