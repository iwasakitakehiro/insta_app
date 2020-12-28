class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @micropost = Micropost.new
  end

  def index
    @micropost = Micropost.find(params[:id])
    @user_id = @micropost.user_id
    @user = User.find(@user_id)
    @comment = Comment.new
    @comments = @micropost.comments.order(created_at: :desc)
  end
  
  def show
    @micropost = Micropost.find(params[:id])
    @comment = Comment.new
    @comments = @micropost.comments.order(created_at: :desc)
    redirect_to micropost_path
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to microposts_index_path(@micropost)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      flash[:warning] = "投稿が正しくありません"
      redirect_to '/sessions/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to root_url
  end

  def search
    if params[:content].present?
      @micropost = Micropost.where('content LIKE ?', "%#{params[:content]}%")
    else
      @micropost = Micropost.none
    end
  end
  
  private

    def micropost_params
      params.require(:micropost).permit(:content, :image)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end