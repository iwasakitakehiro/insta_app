class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    #投稿に紐づいたコメントを作成
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referrer || root_url
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id)
  end
end
