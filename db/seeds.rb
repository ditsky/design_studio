# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Card.create(content: "birthday", card_type: "post card", painted: true, hand_cut: true, img:"https://i.redd.it/fsy15wjyh1j31.jpg")
Card.create(content: "thank you", card_type: "post card", painted: true, hand_cut: true, img:"https://i.redd.it/fsy15wjyh1j31.jpg")
Card.create(content: "sympathy", card_type: "post card", painted: true, hand_cut: true, img:"https://i.redd.it/fsy15wjyh1j31.jpg")
Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: false, img:"https://i.redd.it/fsy15wjyh1j31.jpg")
Card.create(content: "blank", card_type: "fold over", painted: false, hand_cut: true, img:"https://i.redd.it/fsy15wjyh1j31.jpg")
