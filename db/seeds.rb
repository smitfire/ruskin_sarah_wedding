# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
User.destroy_all
attnd = ['false', 'true']

User.create(first: 'Admin', last: 'Admin', email: 'admin@admin.com', password: 'admin', password_confirmation: 'admin', attendance: false)

CSV.foreach('db/MOCK_DATA.csv', :headers => true) do |row|
	User.create(first: row['first_name'], last: row['last_name'], email: row['email'], password: row['first_name'], password_confirmation: row['first_name'], attendance: attnd.sample)
end