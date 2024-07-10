# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  amount           :decimal(, )
#  share_price      :decimal(, )
#  share_qty        :decimal(, )
#  transaction_type :enum             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint
#  stock_id         :bigint
#
require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before :all do
    @trader = User.find_by(email: 'txn@mail.com') || create(:user, :confirmed_email, email: 'txn@mail.com')
    @google_stock = Stock.find_by(ticker: 'GOOG').update(price: 10) || create(:stock, price: 10)
  end

  context 'validations' do
    it 'should only permit acceptable transaction types' do
      acceptable_transaction_types = %w[buy sell deposit withdraw]
      test_transaction_types = acceptable_transaction_types + %w[sales purchases receipts payments]

      test_transaction_types.each do |transaction_type|
        if acceptable_transaction_types.include?(transaction_type)
          expect(build(
                   :transaction,
                   transaction_type:,
                   share_qty: 10,
                   share_price: @google_stock.price,
                   amount: @google_stock.price * 10,
                   user_id: @trader.id,
                   stock_id: @google_stock.id
                 )).to be_valid
          next
        end

        begin
          expect(build(
                   :transaction,
                   transaction_type:,
                   share_qty: 10,
                   share_price: @google_stock.price,
                   amount: @google_stock.price * 10,
                   user_id: @trader.id,
                   stock_id: @google_stock.id
                 )).to_not be_valid
        rescue ArgumentError => e
          puts "Caught error: #{e}"
        end
      end
    end
  end

  context 'calculations' do
  end
end
