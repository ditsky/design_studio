class PagesController < ApplicationController
  
  
  def contact
    @developers = [{:name => "Sam", :email => "sruditsky12@gmail.com"}, 
                    {:name => "Serge", :email => "blahblah@egg.edge"}]

  end

  def home

  end


end
