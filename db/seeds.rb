# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# root_path = "#{Rails.root}/app/assets/images/"


# mfbday = Card.create(content: "birthday", card_type: "post card", painted: true, hand_cut: true, img:"cards/birthday/multifloral-birthday/multifloral-birthday-display.png",
#             short_description: "Multifloral Birthday Card", long_description: "Happy Birthday postcard. 
#                                                                                 This is Original Artwork not printed. The flowers and leaves are Individually painted then cut out and placed in an arrangement.
#                                                                                 The size is 4x6 and comes with an envelope and a piece of parchment to protect the top of the card when mailing.")
# mfbday_path = "cards/birthday/multifloral-birthday/"

# mfbday.display_s3.attach(io: File.open(root_path + mfbday_path + "multifloral-birthday-display.png"), filename: "multifloral-birthday-display.png")
# Dir.foreach(root_path + mfbday_path) do |filename|
#     next if filename == '.' or filename == '..'
#     mfbday.images_s3.attach(io: File.open(root_path + mfbday_path + filename), filename: filename)
#     Image.create(filename: mfbday_path + filename, card_id: mfbday.id)
# end

# pfbday = Card.create(content: "birthday", card_type: "post card", painted: true, hand_cut: true, img:"cards/birthday/pink-floral-birthday/pink-floral-birthday-display.png",
#             short_description: "Pink floral Birthday Card", long_description: "Happy Birthday postcard. 
#                                                                                 This is Original Artwork not printed. The flowers and leaves are Individually painted then cut out and placed in an arrangement.
#                                                                                 The size is 4x6 and comes with an envelope and a piece of parchment to protect the top of the card when mailing.")

# pfbday_path = "cards/birthday/pink-floral-birthday/"

# pfbday.display_s3.attach(io: File.open(root_path + pfbday_path + "pink-floral-birthday-display.png"), filename: "pink-floral-birthday-display.png")
# Dir.foreach(root_path + pfbday_path) do |filename|
#     next if filename == '.' or filename == '..'
#     pfbday.images_s3.attach(io: File.open(root_path + pfbday_path + filename), filename: filename)
#     Image.create(filename: pfbday_path + filename, card_id: pfbday.id)
# end 


# mgl = Card.create(content: "blank", card_type: "post card", painted: true, hand_cut: false, img:"cards/blank/multi-green/multi-green-display.png",
#             short_description: "Multi Green Leaves Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")

# mgl_path = "cards/blank/multi-green/"

# mgl.display_s3.attach(io: File.open(root_path + mgl_path + "multi-green-display.png"), filename: "multi-green-display.png")
# Dir.foreach(root_path + mgl_path) do |filename|
#     next if filename == '.' or filename == '..'
#     mgl.images_s3.attach(io: File.open(root_path + mgl_path + filename), filename: filename)
#     Image.create(filename: mgl_path + filename, card_id: mgl.id)
# end 


# pmmf = Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/mixed-peach-multifloral/mixed-peach-multifloral-display.png",
#             short_description: "Peach Mixed Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")
# pmmf_path = "cards/blank/mixed-peach-multifloral/"

# pmmf.display_s3.attach(io: File.open(root_path + pmmf_path + "mixed-peach-multifloral-display.png"), filename: "mixed-peach-multifloral-display.png")
# Dir.foreach(root_path + pmmf_path) do |filename|
#     next if filename == '.' or filename == '..'
#     pmmf.images_s3.attach(io: File.open(root_path + pmmf_path + filename), filename: filename)
#     Image.create(filename: pmmf_path + filename, card_id: pmmf.id)
# end

# mmmf = Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/mixed-magenta-multifloral/mixed-magenta-multifloral-display.png",
#             short_description: "Magenta Mixed Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")

# mmmf_path = "cards/blank/mixed-magenta-multifloral/"

# mmmf.display_s3.attach(io: File.open(root_path + mmmf_path + "mixed-magenta-multifloral-display.png"), filename: "mixed-magenta-multifloral-display.png")
# Dir.foreach(root_path + mmmf_path) do |filename|
#     next if filename == '.' or filename == '..'
#     mmmf.images_s3.attach(io: File.open(root_path + mmmf_path + filename), filename: filename)
#     Image.create(filename: mmmf_path + filename, card_id: mmmf.id)
# end

# bmmf = Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/mixed-blue-multifloral/mixed-blue-multifloral-display.png",
#             short_description: "Blue Mixed Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")

# bmmf_path = "cards/blank/mixed-blue-multifloral/"    


# bmmf.display_s3.attach(io: File.open(root_path + bmmf_path + "mixed-blue-multifloral-display.png"), filename: "mixed-blue-multifloral-display.png")
# Dir.foreach(root_path + bmmf_path) do |filename|
#     next if filename == '.' or filename == '..'
#     bmmf.images_s3.attach(io: File.open(root_path + bmmf_path + filename), filename: filename)
#     Image.create(filename: bmmf_path + filename, card_id: bmmf.id)
# end

# mmf = Card.create(content: "blank", card_type: "fold over", painted: true, hand_cut: true, img:"cards/blank/magenta-multifloral/magenta-multifloral-display.png",
#             short_description: "Magenta Multifloral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")

# mmf_path = "cards/blank/magenta-multifloral/"

# mmf.display_s3.attach(io: File.open(root_path + mmf_path + "magenta-multifloral-display.png"), filename: "magenta-multifloral-display.png")
# Dir.foreach(root_path + mmf_path) do |filename|
#     next if filename == '.' or filename == '..'
#     mmf.images_s3.attach(io: File.open(root_path + mmf_path + filename), filename: filename)
#     Image.create(filename: mmf_path + filename, card_id: mmf.id)
# end


# #Create Admin Users
# User.create(name: "Jennifer Ruditsky", email: "jenniferruditsky@gmail.com", activated: true, admin: true, password: ENV['ADMIN_PASSWORD'], password_confirmation: ENV['ADMIN_PASSWORD'])
# User.create(name: "Sam Ruditsky", email: "sruditsky@brandeis.edu", activated: true, admin: true, password: ENV['SAM_PASSWORD'], password_confirmation: ENV['SAM_PASSWORD'])

# Card.create(content: "thank you", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
#             short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                         The card is blank inside for you to write your own personal message.
#                                                                         Size is 5x7 and is perfect for framing.")

# Card.create(content: "sympathy", card_type: "post card", painted: true, hand_cut: true, img:"magenta-multifloral-display.png",
#             short_description: "Magenta Multi-floral Card", long_description: "This watercolor card was  painted and hand cut by me in my studio. Each is an original piece of art and is not printed. Every card comes with an envelope and a piece of parchment to protect the card when placed in the envelope. 
#                                                                                 The card is blank inside for you to write your own personal message.
#                                                                                 Size is 5x7 and is perfect for framing.")
                        
AdminPreference.delete_all
AdminPreference.create(homeDesign1: "birthday", homeDesign2: "test",
    homeDesign3: "love", homeDesign4: "thank you",
    greeting_message: "I'm Jennifer and I am a self taught watercolor artist. All of my design's are handpainted original artwork, nothing is printed.")