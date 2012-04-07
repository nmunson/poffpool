namespace :nhl do
  task :update_stats => :environment do
    Team.all.select{|team| team.players.count > 0}.each do |team|
      nhl = NHL.new(ENV['SEASON'])
      resp = nhl.player_stats(team.shortname, true)
      next if resp.code == 404 # stats not available

      resp.parsed_response.each do |player| 
        p = Player.find_by_name(player["name"])
        if player["position"] == "G"
          p.update_attributes(:goals => player["goals"], :assists => player["assists"], :wins => player["wins"], :shutouts => player["shutouts"])
        else
          p.update_attributes(:goals => player["goals"], :assists => player["assists"])
        end
      end
    end
  end
end