namespace :nhl do
  task :update_stats => :environment do
    Team.all.select{|team| team.players.count > 0}.each do |team|
      nhl = NHL.new(ENV['SEASON'])
      resp = nhl.player_stats(team.shortname, true)
      next if resp.code == 404 # stats not available

      goalie_wins = goalie_shutouts = goalie_goals = goalie_assists = 0
      resp.parsed_response.each do |player| 
        if player["position"] == "G"
          goalie_wins += player["wins"]
          goalie_shutouts += player["shutouts"]
          goalie_goals += player["goals"]
          goalie_assists += player["assists"]
        else
          p = Player.find_by_name(player["name"])
          next if p.nil?
          p.update_attributes(:goals => player["goals"], :assists => player["assists"])
        end
      end
      team.goalie.update_attributes(:goals => goalie_goals, :assists => goalie_assists,
        :wins => goalie_wins, :shutouts => goalie_shutouts)
    end

    Entrant.all.sort_by{ |e| e.points }.each_with_index do |entrant, index|
      entrant.rankings.create!(:date => Time.now, :rank => index + 1)
    end
  end
end