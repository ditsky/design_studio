json.extract! card, :id, :content, :card_type, :painted, :hand_cut, :created_at, :updated_at
json.url card_url(card, format: :json)
