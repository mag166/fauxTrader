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
  end

end
