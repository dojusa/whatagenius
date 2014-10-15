class PostsController < ApplicationController
  
  autocomplete :author, :name, :full => true
    
  def index
    @posts = Post.full_search(params[:search]).page(params[:page]).desc(:date).per(10)
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
  
  def edit
    @post = Post.find(params[:id])
    render 'new'
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to post_path
    else
      render 'new'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    index()
    render 'index'
  end
  
  def like
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
  
  def top_posts
    @tops = Post.desc(:likes).limit(5)
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :file, :author_id, :body, :description)
    end
end
