# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create default admin account
admin = User.new(
  email: 'admin@test.com',
  password: 'foobar',
  password_confirmation: 'foobar',
  role: 'admin',
  admin_created: true
)

admin.skip_confirmation!
admin.save

# Populate Stocks table with data from company_list.csv
require 'csv'

CSV.foreach('db/seeds/company_list.csv', headers: true) do |row|
  next unless !row['name'].nil? && row['assetType'] == 'Stock' && row['status'] == 'Active'

  Stock.create(
    ticker: row['symbol'],
    company_name: row['name']
  )

  # For debugging only. Enjoy the Matrix simulation.
  p Stock.last
end
