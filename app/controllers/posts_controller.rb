class PostsController < ApplicationController
  
  def index
    @posts = Post.desc(:date).page(params[:page]).per(10)
    top_posts()
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.date = DateTime.now
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def like
    @post = Post.find(params[:id])
    @post.update_attribute(:likes, @post.likes + 1)
  end
  
  def top_posts
    @tops = Post.desc(:likes).limit(5)
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :author, :body, :description)
    end
end
