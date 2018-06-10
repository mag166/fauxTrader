class CompaniesController < ApplicationController

  def create
    symbol = params[:symbol].upcase
    @company = Company.where(symbol: symbol).first
    if @company == nil
      begin
        symbolCheck = IEX::Resources::Company.get(symbol)
      rescue IEX::Errors::SymbolNotFoundError
        flash[:error] = "#{symbol} is not a valid Company"
        redirect_back fallback_location: root_path

      else
        @company = Company.new(symbol:symbol)
        if @company.save
          flash[:success] = "Added #{symbol} to Companies"
          redirect_to @company
        else
          flash[:error] = "Error adding Company"
        end
      end
    else
      redirect_to @company
    end
  end

  def show
    @company = Company.find(params[:id])
    @companyInfo = IEX::Resources::Company.get(@company.symbol)
    @shares = num_shares(@company)
    @avg = avg_price(@company)
    @price = IEX::Resources::Price.get(@company.symbol)

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

end
