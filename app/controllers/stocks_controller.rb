class StocksController < ApplicationController
  before_action :set_stock_price_service

  def price
    symbol = params[:symbol]
    result = @stock_price_service.price(symbol)
    render json: result, status: :ok
  end

  def prices
    symbols = params[:symbols].split(',')
    result = @stock_price_service.prices(symbols)
    render json: result, status: :ok
  end

  def price_all
    result = @stock_price_service.price_all
    render json: result, status: :ok
  end

  private

  def set_stock_price_service
    @stock_price_service = LatestStockPrice.new(ENV['RAPIDAPI_KEY'])
  end
end
