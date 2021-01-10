desc "This task is called by the Heroku scheduler add-on"
task :clean_guest_carts => :environment do
  puts "Clearing Guest Carts"
  ShoppingCart.where(user_id: nil).delete_all
  puts "done."
end