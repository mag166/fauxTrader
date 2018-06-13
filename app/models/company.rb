class Company < ApplicationRecord
    has_many :user_companies
    has_many :transactions
end
