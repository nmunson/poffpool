namespace :nhl do
  task :populate_teams => :environment do
    teams = [
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
    teams.each { |team|
      Team.create!(team)
    }
  end
end
