class StocksController < ApplicationController
  before_action :set_general_news

  def index
    @q = Stock.ransack(params[:q])
    @stocks = params[:q] ? @q.result(distinct: true) : []
    # initialize @stored_stocks and @stored_news
    return unless params[:q]

    @search_item = params[:q][:company_name_or_ticker_cont]
  end

  def show
    @stock = Stock.find(params[:id])

    if @stock.data
      stock_timeseries = Alphavantage::TimeSeries
                         .new(symbol: @stock.ticker)
                         .daily(outputsize: 'compact')
      @stock.update(data: stock_timeseries.to_json || nil)
    end
    @stock_time_series = JSON.parse(@stock.data)

    if @stock.news
      stock_news = (Alphavantage::Client
                   .new(function: 'NEWS_SENTIMENT', tickers: @stock.ticker)
                   .json
                   .feed || [])
                   .first(10)
      @stock.update(news: stock_news.to_json || nil)
    end
    @stock_news = JSON.parse(@stock.news)

    p 'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
    p @stock_time_series
    p @stock_news
    p 'OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO'
  end

  private

  def set_general_news
    @stock_news = (Alphavantage::Client
                  .new(function: 'NEWS_SENTIMENT')
                  .json
                  .feed || [])
                  .first(10)
  end
end
