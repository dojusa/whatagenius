class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.date = Date.today
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def like
    @post = Post.find(params[:id])
    @post.update_attribute(:likes, @post.likes + 1)
    
    respond_to do |format|
      format.js
    end
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :author, :body, :description)
    end
end
