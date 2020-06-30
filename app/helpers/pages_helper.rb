module PagesHelper

    def get_type(content)
        if content == "birthday"
            return "post card"
        else
            return "fold over"
        end
    end

end
