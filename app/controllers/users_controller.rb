class UsersController < ApplicationController
  before_action :require_login

  def index
    @value = stockPortfolioValue + current_user.cash
    @initialDeposit = current_user.initial_deposit
    @change = (((@value/@initialDeposit)*100)-100).round(2)
    @cash = current_user.cash

    @names = []
    @prices = []
    @symbols = []
    @shares = []
    @avg = []


    @companies = current_user.companies
    @companies.each do |company|
      @symbols.push(company.symbol)
      @prices.push(IEX::Resources::Price.get(company.symbol))
      @names.push(IEX::Resources::Company.get(company.symbol).company_name)
      @avg.push(avg_price(company))
      @shares.push(num_shares(company))
    end
  end

  def num_shares(company)
    transactions = Transaction.where(user_id:current_user.id,company_id:company.id)
    counter = 0
    transactions.each do |transaction|
      if transaction.buy
        counter = counter + transaction.shares
      else
        counter = counter - transaction.shares
      end
    end
    return counter
  end

  def avg_price(company)
    transactions = Transaction.where(user_id:current_user.id,company_id:company.id, buy:true)
    numerator = 0
    denominator = 0
    transactions.each do |transaction|
      numerator = numerator + (transaction.shares*transaction.price)
      denominator = denominator + transaction.shares
    end
    if denominator != 0
      return (numerator/denominator).round(3)
    else
      return '-'
    end
  end

  def stockPortfolioValue
    counter = 0
    current_user.companies.each do |company|
      currentPrice = IEX::Resources::Price.get(company.symbol)
      counter = counter + (num_shares(company)*currentPrice)
    end

    return counter 
  end


  def splash
  end
end
