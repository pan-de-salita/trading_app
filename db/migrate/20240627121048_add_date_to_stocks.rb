class AddDateToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :data, :string
  end
end
