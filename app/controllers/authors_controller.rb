class AuthorsController < ApplicationController
  
  def index
    @authors = Author.asc(:name, :nickname)
  end
  
  def show
    @author = Author.find(params[:id])
  end
  
  def new
    @author = Author.new
  end
  
  def create
    @author = Author.new(author_params)
    
    if @author.save
      redirect_to authors_path
    else
      render 'new'
    end
  end
  
  def edit
    @author = Author.find(params[:id])
    render 'new'
  end
  
  def update
    @author = Author.find(params[:id])
    
    if @author.update(author_params)
      redirect_to authors_path
    else
      render 'new'
    end
  end
  
  def destroy
    @author = Author.find(params[:id])
    
    @author.destroy
      
    @authors = Author.asc(:name, :nickname)    
  end
  
  private
    def author_params
      params.require(:author).permit(:name, :nickname, :description)
    end
end
