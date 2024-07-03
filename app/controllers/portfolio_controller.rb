class PortfolioController < ApplicationController
  before_action :check_trader_approved?

  def index
    
    @stocks = current_user.stocks
    @transactions = current_user.transactions

    @historical_data = {
      "meta_data"=>{"information"=>"Daily Prices (open, high, low, close) and Volumes", "symbol"=>"MSFT", "last_refreshed"=>"2024-06-28", "output_size"=>"Compact", "time_zone"=>"US/Eastern"},
      "time_series_daily"=>
       {"2024-06-28"=>{"open"=>"453.0700", "high"=>"455.3800", "low"=>"446.4100", "close"=>"446.9500", "volume"=>"28362271"},
        "2024-06-27"=>{"open"=>"452.1750", "high"=>"456.1700", "low"=>"451.7700", "close"=>"452.8500", "volume"=>"14806324"},
        "2024-06-26"=>{"open"=>"449.0000", "high"=>"453.6000", "low"=>"448.1900", "close"=>"452.1600", "volume"=>"16507030"},
        "2024-06-25"=>{"open"=>"448.2500", "high"=>"451.4200", "low"=>"446.7500", "close"=>"450.9500", "volume"=>"16747529"},
        "2024-06-24"=>{"open"=>"449.8000", "high"=>"452.7500", "low"=>"446.4100", "close"=>"447.6700", "volume"=>"15913719"},
        "2024-06-21"=>{"open"=>"447.3800", "high"=>"450.5800", "low"=>"446.5100", "close"=>"449.7800", "volume"=>"34486172"},
        "2024-06-20"=>{"open"=>"446.3000", "high"=>"446.5300", "low"=>"441.2700", "close"=>"445.7000", "volume"=>"19877378"},
        "2024-06-18"=>{"open"=>"449.7050", "high"=>"450.1400", "low"=>"444.8900", "close"=>"446.3400", "volume"=>"17112504"},
        "2024-06-17"=>{"open"=>"442.5850", "high"=>"450.9400", "low"=>"440.7200", "close"=>"448.3700", "volume"=>"20790030"},
        "2024-06-14"=>{"open"=>"438.2750", "high"=>"443.1376", "low"=>"436.7210", "close"=>"442.5700", "volume"=>"13581985"},
        "2024-06-13"=>{"open"=>"440.8500", "high"=>"443.3900", "low"=>"439.3700", "close"=>"441.5800", "volume"=>"15960565"},
        "2024-06-12"=>{"open"=>"435.3200", "high"=>"443.4000", "low"=>"433.2500", "close"=>"441.0600", "volume"=>"22366233"},
        "2024-06-11"=>{"open"=>"425.4750", "high"=>"432.8200", "low"=>"425.2500", "close"=>"432.6800", "volume"=>"14551101"}
  }
}

  @formatted_data = format_stock_data(@historical_data["time_series_daily"])

  @combined_data = @formatted_data.each_with_object({}) do |data, hash|
  hash[data[:time]] = [data[:open], data[:close], data[:low], data[:high]]
end

puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts @historical_data
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts @formatted_data
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
puts @formatted_data.map { |data| [[data[:time], data[:open], data[:high], data[:low], data[:close]]] }
puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

  end

  private

  def format_stock_data(stock_data)
    stock_data.map do |time, data|
      {
        time: Time.parse(time.to_s),
        open: data["open"].to_f,
        high: data["high"].to_f,
        low: data["low"].to_f,
        close: data["close"].to_f,
        volume: data["volume"].to_i
      }
    end
  end
end
