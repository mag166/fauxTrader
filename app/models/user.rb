class User < ApplicationRecord
  include Clearance::User
  has_many :user_companies
  has_many :companies, through: :user_companies
  has_many :transactions
end
