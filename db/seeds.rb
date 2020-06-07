# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Card.create(content: "birthday", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
            short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")
                                                                                
Card.create(content: "thank you", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
            short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")

Card.create(content: "sympathy", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
            short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")

Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: false, img:"magenta-multifloral-display.png",
            short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")
                                                                                
Card.create(content: "blank", card_type: "fold over", painted: false, hand_cut: true, img:"magenta-multifloral-display.png",
            short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")

Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
            short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")
