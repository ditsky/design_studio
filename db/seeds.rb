# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Card.create(content: "birthday", card_type: "post card", painted: true, hand_cut: true, img:"cards/birthday/multifloral-birthday/multifloral-birthday-display.png",
            short_description: "Multifloral Birthday Card", long_description: "Happy Birthday postcard. 
                                                                                This is Original Artwork not printed. The flowers and leaves are Individually painted then cut out and placed in an arrangement.
                                                                                The size is 4x6 and comes with an envelope and a piece of parchment to protect the top of the card when mailing.")
                                                                                

Card.create(content: "birthday", card_type: "post card", painted: true, hand_cut: true, img:"cards/birthday/pink-floral-birthday/pink-floral-birthday-display.png",
            short_description: "Pink floral Birthday Card", long_description: "Happy Birthday postcard. 
                                                                                This is Original Artwork not printed. The flowers and leaves are Individually painted then cut out and placed in an arrangement.
                                                                                The size is 4x6 and comes with an envelope and a piece of parchment to protect the top of the card when mailing.")

Card.create(content: "blank", card_type: "post card", painted: true, hand_cut: false, img:"cards/blank/multi-green/multi-green-display.png",
            short_description: "Multi Green Leaves Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")

Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/mixed-peach-multifloral/mixed-peach-multifloral-display.png",
            short_description: "Peach Mixed Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")


Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/mixed-magenta-multifloral/mixed-magenta-multifloral-display.png",
            short_description: "Magenta Mixed Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")
                                                                                
Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/mixed-blue-multifloral/mixed-blue-multifloral-display.png",
            short_description: "Blue Mixed Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")

Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/magenta-multifloral/magenta-multifloral-display.png",
            short_description: "Magenta Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
                                                                                The card is blank inside for you to write your own personal message.
                                                                                Size is 5x7 and is perfect for framing.")


# Card.create(content: "thank you", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
#             short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                         The card is blank inside for you to write your own personal message.
#                                                                         Size is 5x7 and is perfect for framing.")

# Card.create(content: "sympathy", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
#             short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")
                                                                        