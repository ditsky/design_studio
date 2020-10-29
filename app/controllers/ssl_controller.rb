class SslController < ApplicationController

    def verify
        respond_to do |format|
            format.html
            format.json { render json: "XHFRj0z1DIwRzhB60X7ztfJk47u0x_LDKZq0aNZxQHk.uw2lzAVMOAsd6i4K6B3ioxMvGSO7rEMhaxUmdN6gzlE"}
        end
    end

end