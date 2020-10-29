class SslController < ApplicationController

    def verify
        respond_to do |format|
            format.html
            format.json { render json: "3JshJRHEwH8Tk5jyjBvagpaN9eYV9XjvP3sM7iq5RUo.uw2lzAVMOAsd6i4K6B3ioxMvGSO7rEMhaxUmdN6gzlE"}
        end
    end

end