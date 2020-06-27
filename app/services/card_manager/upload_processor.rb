module CardManager

    class UploadProcessor


        def upload(images, display_image, card)
            
            folder_path = Rails.root.join('app', 'assets', 'images', 'cards', 'uploads')
            if Rails.env.production? 
                folder_path = Rails.root.join('assets', 'images', 'cards', 'uploads')
            end
            images.each do |image|
                image_path = folder_path.join(image.original_filename)
                File.open(image_path, 'wb') do |file|
                    file.write(image.read)
                end
                asset_path = "cards/uploads/" + image.original_filename
                Image.create(filename: asset_path, card_id: card.id)
                if image == display_image
                    card.update(img: asset_path)
                end
            end

        end

        def delete(images)
            images.each do |image|
                image_path = Rails.root.join('app', 'assets', 'images', image.filename)
                File.delete(image_path) if File.exist?(image_path)
            end
            images.delete_all
        end




    end


end