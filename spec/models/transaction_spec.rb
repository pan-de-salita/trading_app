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
  pending "add some examples to (or delete) #{__FILE__}"
end
