class StocksController < ApplicationController
  before_action :check_trader_confirmed?

  def index
    @q = Stock.ransack(params[:q])
    @stocks = params[:q] ? @q.result(distinct: true) : []

    @general_news = Rails.cache.fetch('general_news', expires_in: 12.hours) do
      response = Alphavantage::Client.new(function: 'NEWS_SENTIMENT').json
      response.feed unless response.information
    end
    console
  end

  def show
    @stock = Stock.find(params[:id])
    @stock.set_or_fetch_from_alphavantage
    @stock_timeseries = JSON.parse(@stock.data) unless @stock.data.nil?
    @stock_news = JSON.parse(@stock.news) unless @stock.news.nil?
    console
  end
end
