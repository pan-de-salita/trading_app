# == Schema Information
#
# Table name: stocks
#
#  id           :bigint           not null, primary key
#  ticker       :string
#  company_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  data         :string
#  news         :string
#  price        :decimal(, )
#  open         :decimal(, )
#  high         :decimal(, )
#  low          :decimal(, )
#  volume       :bigint
#
require "test_helper"

class StockTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
