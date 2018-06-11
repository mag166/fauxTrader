class TransactionsController < ApplicationController
  def index
  end

  def create
    @company = Company.find(params[:company_id].to_i)
    name = IEX::Resources::Company.get(@company.symbol).company_name
      if params[:buy] == "true"
          cashValue = (current_user.cash.to_f - (params[:price].to_f*params[:shares].to_f)).round(3)
          if cashValue > 0
              @transaction = Transaction.new(user_id:current_user.id,company_id:params[:company_id], price:params[:price],shares:params[:shares],buy:params[:buy])
              if @transaction.save
                  current_user.update(cash:cashValue)
                  if UserCompany.where(user_id: current_user.id, company_id:params[:company_id].to_i).empty?
                      UserCompany.create(user_id: current_user.id, company_id:params[:company_id].to_i)
                  end
                  flash[:success] = "Successfully purchased #{params[:shares]} shares of #{name}"
                  redirect_to @company
              else
                  flash[:error] = "There was an Error with your purchase. Please Try Again."
                  redirect_to @company
              end
          else
              flash[:error] = "You don't have enough money to complete this purchase"
              redirect_to @company
          end
      else
          puts "43"
          cashValue = (current_user.cash.to_f + (params[:price].to_f*params[:shares].to_f)).round(3)
          puts "44"
          if params[:totalShares].to_i >= params[:shares].to_i 
              @transaction = Transaction.new(user_id:current_user.id,company_id:params[:company_id], price:params[:price],shares:params[:shares],buy:params[:buy])
              if @transaction.save
                  puts "saving"
                  current_user.update(cash:cashValue)
                  flash[:success] = "Successfully sold #{params[:shares]} shares of #{name}"
                redirect_to @company
              else
                  puts "error"
                  flash[:error] = "There was an Error with your purchase. Please Try Again."
                  redirect_to @company
              end
          else
              puts "no money"
              flash[:error] = "You don't have enough shares to sell"
              redirect_to @company
          end
      end
  end
end