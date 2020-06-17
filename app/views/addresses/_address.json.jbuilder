json.extract! address, :id, :country, :full_name, :address_line_1, :address_line_2, :city, :state, :zip, :phone_number, :user_id, :created_at, :updated_at
json.url address_url(address, format: :json)
