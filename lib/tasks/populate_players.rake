namespace :nhl do
  task :populate_players => :environment do
    # use ENV var pointing to nhl api
    # use ENV var that has list of shortnames of teams in playoffs
    # for each team in the list of playoff teams
      # ask the nhl api for details on that team, in this regular season
      # save top 6 players, top 2 goalies

    ENV['PLAYOFF_TEAMS'].split(',').each do |team|
      @team = Team.find_by_shortname(team)
      nhl = NHL.new(ENV['SEASON'])
      resp = nhl.player_stats(team)
      player_list = resp.parsed_response.select{|p| p["position"] != "G"}
      goalie_list = resp.parsed_response.select{|g| g["position"] == "G"}

      player_list.sort_by{|h| h[:points]}.take(6).each do |player|
        @team.players.create(:name => player["name"], :season_points => player["points"])
      end
    end
  end
end