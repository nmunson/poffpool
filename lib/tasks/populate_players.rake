namespace :nhl do
  desc "Fill player data for playoff teams"
  task :populate_players => :environment do
    nhl = NHL.new(ENV['SEASON'])
    nhl.create_players
  end
end