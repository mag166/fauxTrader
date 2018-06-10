# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: "test@test.com", password: "test123", cash:7000, initial_deposit: 10000 )
Company.create(symbol:"MSFT")
Company.create(symbol:"F")
Company.create(symbol:"AAPL")
Company.create(symbol:"NVAX")

UserCompany.create(user_id:1, company_id:1)
UserCompany.create(user_id:1, company_id:2)
UserCompany.create(user_id:1, company_id:3)
UserCompany.create(user_id:1, company_id:4)

Transaction.create(user_id:1, company_id:1, shares:30, price: 30.49, created_at:DateTime.parse('March 3rd 2013 04:05:06 AM'),buy:true)
Transaction.create(user_id:1, company_id:1, shares:13, price: 45.99, created_at:DateTime.parse('March 13th 2013 04:05:06 AM'),buy:true)