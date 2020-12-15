module LikesHelper
  def like_count
    favorite = @micropost.likes
    number = favorite.count
  end
end
