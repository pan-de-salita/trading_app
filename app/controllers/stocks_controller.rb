class StocksController < ApplicationController
  def index
    
    @q = Stock.ransack(params[:q])
    @stocks = @q.result(distinct: true)

    # For testing only:
    #@stocks = Stock.first(5)

    # TODO: incorporate ransack
    # NOTE: ransack configs are done on the model level, i believe
  end

  def show; end
end
