class PizzasController < ApplicationController
  def index
    @pizza = Pizza.new
    @pizzas_by_author = Pizza.group_by_author
  end
  
  def new
    @pizza = Pizza.new
  end
  
  def create
    @pizza = Pizza.new(post_params)
    @pizza.save
    redirect_to pizzas_path
  end
  
  private
    def post_params
      params.require(:pizza).permit(:motivo, :author_id)
    end
end