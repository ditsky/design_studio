require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should get new" do
    get new_card_url
    assert_response :success
  end

  test "should create card" do
    assert_difference('Card.count') do
      post cards_url, params: { card: { card_type: @card.card_type, content: @card.content, hand_cut: @card.hand_cut, painted: @card.painted } }
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: { card: { card_type: @card.card_type, content: @card.content, hand_cut: @card.hand_cut, painted: @card.painted } }
    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete card_url(@card)
    end

    assert_redirected_to cards_url
  end

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
