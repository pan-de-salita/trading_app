FactoryBot.define do
  factory :stock do
    ticker { "MyString" }
    company_name { "MyString" }
    data { "MyString" }
    news { "MyString" }
    price { "9.99" }
    open { "9.99" }
    high { "9.99" }
    low { "9.99" }
    volume { "" }
  end
end
