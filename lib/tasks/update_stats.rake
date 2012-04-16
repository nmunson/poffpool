namespace :nhl do
  task :update_stats => :environment do
    skipped_team_count = 0
    Team.all.select{|team| team.players.count > 0}.each do |team|
      nhl = NHL.new(ENV['SEASON'])
      resp = nhl.player_stats(team.shortname, true)
      if resp.code == 404 # stats not available
        skipped_team_count += 1
        next
      end

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

    # check for team shutouts and add appropriately
    unless ENV['TEAM_SHUTOUTS'].nil?
      ENV['TEAM_SHUTOUTS'].split(",").each do |x|
        team_id = Integer(x.split(":").first)
        team_shutout_count = Integer(x.split(":").last)
        team = Team.find(team_id)
        team.goalie.update_attributes(:shutouts => team.goalie.shutouts + team_shutout_count)
      end
    end

    # don't log rankings if no teams are reporting back statistics yet
    unless skipped_team_count == Team.all.select{|team| team.players.count > 0}
      Entrant.all.sort_by{ |e| -e.points }.each_with_index do |entrant, index|  
        entrant.rankings.create!(:date => Time.now, :rank => index + 1)
      end
    end
  end
end