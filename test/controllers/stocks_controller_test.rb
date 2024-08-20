require "test_helper"

class StocksControllerTest < ActionDispatch::IntegrationTest
  test "should get price" do
    get stocks_price_url
    assert_response :success
  end

  test "should get prices" do
    get stocks_prices_url
    assert_response :success
  end

  test "should get price_all" do
    get stocks_price_all_url
    assert_response :success
  end
end
