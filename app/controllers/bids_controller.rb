class BidsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @bids = Bid.all
    authorize! :read, @bids
  end

  def edit
    @bid = Bid.find(params[:id])
    authorize! :read, @bid
  end

  def update
    @bid = Bid.find(params[:id])
    authorize! :update, @bid

    if @bid.update(bid_params)
      redirect_to bids_path, notice: 'Bid was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def create
    @bid = Bid.new(bid_params)
    @bid.user = current_user
    @bid.loan = Loan.find(params[:loan_id])

    if @bid.save
      redirect_to @bid.loan, notice: 'Bid was successfully created.'
    else
      redirect_to @bid.loan, alert: 'Couldn\'t place the bid.'
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end

end
