module StocksHelper

  #helper to format numerical values to display any number of decimal values
  def display_with_decimals(number, decimal_places)
    float = number.to_f
    formatted_number = sprintf("%.*f", decimal_places, float)
    formatted_number
  end
end
