namespace :nhl do
  desc "Fill player data for playoff teams"
  task :populate_players => :environment do
    injury_list = ENV['INJURIES'].split(",")
    ENV['PLAYOFF_TEAMS'].split(',').each do |team|
      @team = Team.find_by_shortname(team)
      nhl = NHL.new(ENV['SEASON'])
      resp = nhl.player_stats(team)
      player_list = resp.parsed_response.select{|p| p["position"] != "G"}.sort_by{|h| h[:points]}

      while @team.players.count != 6
        index = @team.players.count + 1
        player = player_list.shift
        next if injury_list.include?(player["name"])
        
        position = ""
        if index <= 5
          position = "col#{index}"
        else
          position = "mulligan"
        end

        @team.players.create!(
          :name => player["name"], 
          :season_points => player["points"], 
          :position => position
        )
      end

      # Goalies are referenced by the top two goalies on the team, but their points count always comes from
      # any goalie playing for the team.  Wins and shutouts count for extra points based on the multipliers.
      goalie_list = resp.parsed_response.select{|g| g["position"] == "G"}
      goalie_season_points = 0
      goalie_names = []
      goalie_list.sort_by{|h| h[:wins]}.each do |goalie|
        goalie_season_points += (goalie["wins"] * Integer(ENV['WIN_MULTIPLIER'])) + 
          (goalie["shutouts"] * Integer(ENV['SHUTOUT_MULTIPLIER'])) + goalie["goals"] + goalie["assists"]
        goalie_names << goalie["name"] 
      end
      @team.players.create!(
        :name => goalie_names.take(2).join("/"), 
        :season_points => goalie_season_points, 
        :position => "goalie"
      )
    end
  end
end