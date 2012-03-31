class NHL
  include HTTParty
  base_uri ENV['NHL_API']

  def initialize(season)
    @season = season
  end

  def player_stats(team, playoffs=false)
    self.class.get("/#{team}/#{@season}")
  end

end