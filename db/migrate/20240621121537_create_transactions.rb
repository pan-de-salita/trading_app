class CreateTransactions < ActiveRecord::Migration[7.1]
    create_enum :transaction_type, %w[
      deposit
      withdraw
      buy
      sell
      ]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.decimal :share_price
      t.decimal :share_qty
      t.enum :transaction_type, enum_type: 'transaction_type', null: false
      t.timestamps
    end
  end
end
