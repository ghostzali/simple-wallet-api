# frozen_string_literal: true
require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = "https://latest-stock-price.p.rapidapi.com/"

  def initialize(api_key)
    @api_key = api_key
  end

  def price(symbol)
    request("stock/price/#{symbol}")
  end

  def prices(symbols)
    request("stock/prices?symbols=#{symbols.join(',')}")
  end

  def price_all
    request("stock/price_all")
  end

  private

  def request(endpoint)
    uri = URI("#{BASE_URL}#{endpoint}")
    req = Net::HTTP::Get.new(uri)
    req['X-RapidAPI-Key'] = @api_key

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    JSON.parse(res.body)
  rescue StandardError => e
    { error: e.message }
  end
end
