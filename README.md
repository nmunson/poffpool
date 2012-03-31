# poffpool - An NHL Playoff Pool Application

This application runs a custom playoff pool.  The pool lets entrants pick players out of a grid following a 
specific set of rules.  

## Installation

1. Set your environment variables found in config/environment_vars.rb.

2. Populate all teams with:

        rake nhl:populate_teams

3. Once the regular season has completed, run the rake task to populate players:

        rake nhl:populate_players
