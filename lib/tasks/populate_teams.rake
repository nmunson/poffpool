namespace :nhl do
  desc "Fill the database with all NHL teams"
  task :populate_teams => :environment do
    NHL.create_teams
  end
end
