
namespace :db do
  desc "Check if the database exists"
  task exists: :environment do
    begin
      ActiveRecord::Base.connection
      puts "Database exists"
      exit 0 # Exit with a status of 0 to indicate success
    rescue ActiveRecord::NoDatabaseError
      puts "Database does not exist"
      exit 1 # Exit with a status of 1 to indicate failure
    end
  end
end
