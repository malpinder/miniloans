class LoansController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  before_action :set_loan, only: [:show, :edit, :update, :destroy]

  def index
    @loans = Loan.all
  end

  def show
  end

  def new
    @loan = Loan.new
    authorize! :create, @loan
  end

  def edit
    authorize! :update, @loan
  end

  def create
    @loan = Loan.new(loan_params)
    authorize! :create, @loan

    if @loan.save
      redirect_to @loan, notice: 'Loan was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    authorize! :update, @loan
    if @loan.update(loan_params)
      redirect_to @loan, notice: 'Loan was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan
      @loan = Loan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_params
      params.require(:loan).permit(:title, :business_name, :amount, :description)
    end
end
