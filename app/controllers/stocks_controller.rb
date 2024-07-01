# frozen_string_literal: true

class StocksController < ApplicationController
  GENERAL_NEWS = Alphavantage::Client.new(function: 'NEWS_SENTIMENT').json.freeze

  def index
    p GENERAL_NEWS
    @q = Stock.ransack(params[:q])
    @stocks = params[:q] ? @q.result(distinct: true) : []

    # news_articles = Stock.all.map { |stock| JSON.parse(stock.news) unless stock.news.nil? }.compact.flatten
    # @random_news_articles = news_articles.sample(12)
    @random_news_articles = GENERAL_NEWS.sample(12)
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
