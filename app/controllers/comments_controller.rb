class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_loan

  def new
    @comment = @loan.comments.build
  end

  def create
    @comment = @loan.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @loan, notice: 'Comment was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
