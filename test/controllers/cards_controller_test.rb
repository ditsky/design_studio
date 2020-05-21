require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get birthday" do
    get cards_birthday_url
    assert_response :success
  end

  test "should get anniversary" do
    get cards_anniversary_url
    assert_response :success
  end

  test "should get sympathy" do
    get cards_sympathy_url
    assert_response :success
  end

end
