class AddNewsToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :news, :string
  end
end
