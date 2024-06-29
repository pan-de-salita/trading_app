class AddPriceAndOpenAndHighAndLowAndVolumeToStock < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :price, :decimal
    add_column :stocks, :open, :decimal
    add_column :stocks, :high, :decimal
    add_column :stocks, :low, :decimal
    add_column :stocks, :volume, :bigint
    Stock.update_all(price: 0.0, open: 0.0, high: 0.0, low: 0.0, volume: 0)
  end
end
