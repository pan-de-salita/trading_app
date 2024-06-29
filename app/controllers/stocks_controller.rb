class StocksController < ApplicationController
  # before_action :set_general_news

  def index
    @q = Stock.ransack(params[:q])
    @stocks = params[:q] ? @q.result(distinct: true) : []
    stock = Stock.all
    news_articles = stock.map { |stock| JSON.parse(stock.news) unless stock.news.nil? }.compact.flatten
    @random_news_articles = news_articles.sample(12)
    console
  end

  def show
    @stock = Stock.find(params[:id])
    @stock.set_or_fetch_from_alphavantage
    @stock_timeseries = JSON.parse(@stock.data) unless @stock.data.nil?
    @stock_news = JSON.parse(@stock.news) unless @stock.news.nil?
    console
  end

  private

  # def set_general_news
  #   general_news = Alphavantage::Client.new(function: 'NEWS_SENTIMENT').json
  #   session[:general_news] = general_news['feed'].first(9) unless general_news.information
  #   @general_news = !general_news.information ? JSON.parse(general_news)['feed'].first(9) : session[:general_news]
  # end
end
