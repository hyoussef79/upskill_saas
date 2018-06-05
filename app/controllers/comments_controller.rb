class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user

  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'comment updated!'
      redirect_to user_path(params[:user_id])
    else
      render action: :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :message
    )
  end

  def only_current_user
    @user = User.find(params[:user_id])
    redirect_to root_path unless @user == current_user
  end
end
