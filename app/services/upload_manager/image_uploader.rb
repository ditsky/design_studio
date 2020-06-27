module UploadManager

    class ImageUploader


        def upload(images, display_image, card)
            folder_path = Rails.root.join('app', 'assets', 'images', 'cards', 'uploads')
            
            images.each do |image|
                image_path = folder_path.join(image.original_filename)
                File.open(image_path, 'wb') do |file|
                    file.write(image.read)
                end
                asset_path = "cards/uploads/" + image.original_filename
                Image.create(filename: asset_path, card_id: card.id)
                if image == display_image
                    card.update(img: image_path)
                end
            end

        end




    end


end