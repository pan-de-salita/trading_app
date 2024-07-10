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
FactoryBot.define do
  factory :stock do
    ticker { 'GOOG' }
    company_name { 'Alphabet Inc - Class C' }
  end
end
