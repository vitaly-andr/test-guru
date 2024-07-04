namespace :db do
  desc "Annotate models"
  task annotate_models: :environment do
    puts "Annotating models..."
    system 'bundle exec annotate --models'
    puts "Models annotated."
  end

  task :migrate do
    Rake::Task["db:annotate_models"].invoke
  end

  task :rollback do
    Rake::Task["db:annotate_models"].invoke
  end
end
