class AddUserAndStockToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :user, index: true, foreign_key: true
    add_reference :transactions, :stock, index: true, foreign_key: true
  end
end
