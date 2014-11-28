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
    @post.user = current_user
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
    if @post.user.nil?
      @post.user = current_user
    end
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
  
  def top_posts
    @tops = Post.desc(:likes).limit(5)
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :file, :author_id, :body, :description)
    end
end
