class LikesController < ApplicationController
  
  def like_unlike
    @post = Post.find(params[:id])
    
    if user_signed_in?
      if current_user.already_liked?(@post)
        @like = Like.where(post: @post, user: current_user)
        unless @like.nil?
          @like.destroy
        end
      else
        @like = Like.new
        @like.post = @post
        @like.user = current_user
        @like.save        
      end
    end
  end
  
end