class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :company_name

      t.timestamps
    end
  end
end
