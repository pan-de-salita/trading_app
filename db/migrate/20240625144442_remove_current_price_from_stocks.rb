class RemoveCurrentPriceFromStocks < ActiveRecord::Migration[7.1]
  def change
    remove_column :stocks, :current_price, :decimal
  end
end
