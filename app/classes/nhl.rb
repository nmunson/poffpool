class NHL
  include HTTParty
  base_uri ENV['NHL_API']

  def initialize(season)
    @season = season
  end

  def player_stats(team, playoffs=false)
    if playoffs
      self.class.get("/#{team}/#{@season}/playoffs")
    else
      self.class.get("/#{team}/#{@season}")
    end
  end

  def self.create_teams
    teams.each { |team|
      Team.create!(team)
    }
  end

  def create_players
    validate_playoff_teams
    playoff_teams.each do |team|
      create_team_players(team)
      create_team_goalies(team)
    end
  end

  private

  def validate_playoff_teams
    playoff_teams.each do |team|
      unless self.class.teams.any? {|t| t["shortname"] == team}
        raise ArgumentError, "Playoff team #{team} does not exist" 
      end
    end
  end

  def playoff_teams
    ENV['PLAYOFF_TEAMS'].split(',')
  end

  def create_team_players(team)
    team = Team.find_by_shortname(team)
    resp = player_stats(team)
    player_list = resp.parsed_response.select{|p| p["position"] != "G"}.sort_by{|h| h[:points]}

    while team.players.count != 6
      index = team.players.count + 1
      player = player_list.shift
      next if injury_list.include?(player["name"])
      
      position = ""
      if index <= 5
        position = "col#{index}"
      else
        position = "mulligan"
      end

      team.players.create!(
        :name => player["name"], 
        :season_points => player["points"], 
        :position => position
      )
    end
  end

  def create_team_goalies(team)
    team = Team.find_by_shortname(team)
    resp = player_stats(team)

    # Goalies are referenced by the top two goalies on the team, but their points count always comes from
    # any goalie playing for the team.  Wins and shutouts count for extra points based on the multipliers.
    goalie_list = resp.parsed_response.select{|g| g["position"] == "G"}
    goalie_season_points = 0
    goalie_names = []
    goalie_list.sort_by{|h| h[:wins]}.each do |goalie|
      goalie_season_points += (goalie["wins"] * wins_multiplier) + 
        (goalie["shutouts"] * shutout_multiplier) + goalie["goals"] + goalie["assists"]
      goalie_names << goalie["name"] 
    end
    team.players.create!(
      :name => goalie_names.take(2).join("/"), 
      :season_points => goalie_season_points, 
      :position => "goalie"
    )
  end

  def wins_multiplier
    Integer(ENV['WIN_MULTIPLIER'])
  end

  def shutout_multiplier
    Integer(ENV['SHUTOUT_MULTIPLIER'])
  end

  def injury_list
    ENV['INJURIES'].split(",")
  end

  def self.teams
    [
      { "name" => "New Jersey Devils", "shortname" => "devils" },  
      { "name" => "New York Islanders", "shortname" => "islanders" },  
      { "name" => "New York Rangers", "shortname" => "rangers" },  
      { "name" => "Philadelphia Flyers", "shortname" => "flyers" },  
      { "name" => "Pittsburgh Penguins", "shortname" => "penguins" },  
      { "name" => "Boston Bruins", "shortname" => "bruins" },  
      { "name" => "Buffalo Sabres", "shortname" => "sabres" },  
      { "name" => "Montreal Canadiens", "shortname" => "canadiens" },  
      { "name" => "Ottawa Senators", "shortname" => "senators" },  
      { "name" => "Toronto Maple Leafs", "shortname" => "mapleleafs" },  
      { "name" => "Carolina Hurricanes", "shortname" => "hurricanes" },  
      { "name" => "Florida Panthers", "shortname" => "panthers" },  
      { "name" => "Tampa Bay Lightning", "shortname" => "lightning" },  
      { "name" => "Washington Capitals", "shortname" => "capitals" },  
      { "name" => "Winnipeg Jets", "shortname" => "jets" },  
      { "name" => "Chicago Blackhawks", "shortname" => "blackhawks" },  
      { "name" => "Columbus Blue Jackets", "shortname" => "bluejackets" },  
      { "name" => "Detroit Red Wings", "shortname" => "redwings" },  
      { "name" => "Nashville Predators", "shortname" => "predators" },  
      { "name" => "St. Louis Blues", "shortname" => "blues" },  
      { "name" => "Calgary Flames", "shortname" => "flames" },  
      { "name" => "Colorado Avalanche", "shortname" => "avalanche" },  
      { "name" => "Edmonton Oilers", "shortname" => "oilers" },  
      { "name" => "Minnesota Wild", "shortname" => "wild" },  
      { "name" => "Vancouver Canucks", "shortname" => "canucks" },  
      { "name" => "Anaheim Ducks", "shortname" => "ducks" },  
      { "name" => "Dallas Stars", "shortname" => "stars" },  
      { "name" => "Los Angeles Kings", "shortname" => "kings" },  
      { "name" => "Phoenix Coyotes", "shortname" => "coyotes" },  
      { "name" => "San Jose Sharks", "shortname" => "sharks" }  
    ]
  end

end