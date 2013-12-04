class RepliesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_comment

  def new
    @reply = @comment.replies.build
  end

  def create
    @reply = @comment.replies.build(reply_params)
    @reply.user_id = current_user.id

    if @reply.save
      redirect_to @comment.loan, notice: 'Reply was successfully created.'
    else
      render action: 'new'
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def reply_params
    params.require(:comment).permit(:text)
  end
end
