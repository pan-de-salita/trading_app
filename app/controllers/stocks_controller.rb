class StocksController < ApplicationController
  def index
    # For testing only:
    @stocks = Stock.first(5)

    # TODO: incorporate ransack
    # NOTE: ransack configs are done on the model level, i believe
  end

  def show; end
end
