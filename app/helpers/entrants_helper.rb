module EntrantsHelper

  def player_type(index)
    case index
    when 0
      return "col1"
    when 1
      return "col2"
    when 2
      return "col3"
    when 3
      return "col4"
    when 4
      return "col5"
    when 5
      return "mulligan"
    when 6
      return "goalie"
    end
  end

end
