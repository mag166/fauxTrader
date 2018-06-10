class CompaniesController < ApplicationController
  def index
    @company = Company.new
  end

  def create
    @company = Company.new
    puts params[:symbol]
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.new
  end
end
