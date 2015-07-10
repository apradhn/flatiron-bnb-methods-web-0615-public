namespace :db do 
  desc "Fires up a pry console"
  task :console => :environment do 
    binding.pry
  end
end