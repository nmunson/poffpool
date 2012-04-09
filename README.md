# poffpool - An NHL Playoff Pool Application

This application runs a custom playoff pool.  The pool lets entrants pick players out of a grid following a 
specific set of rules.  

## Installation

1. Set your environment variables found in config/environment_vars.rb.

2. Populate all teams with:

        rake nhl:populate_teams

3. Once the regular season has completed, run the rake task to populate players:

        rake nhl:populate_players

4. Set up a scheduled task to update the statistics regulary, and which will call the following rake task:

        rake nhl:update_stats

## Copyright

Copyright 2012 Nicholas Munson
All rights reserved.

## License

[GPLv3](http://www.gnu.org/licenses/gpl-3.0.html)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see: http://www.gnu.org/licenses/