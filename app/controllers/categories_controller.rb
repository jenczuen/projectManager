class CategoriesController < ApplicationController
  def all
    categories = Category.all

    render json: categories
  end

  def get
    category = Category.find(params[:id])

    render json: category
  end

  def create
    if signed_in?
      Category.create(name: params[:name],
                    description: params[:description])
      
      render json: :nothing, :status => 200
    else
      render json: "Guest can't create new categories!", status: 401
    end
  end
  
  def update
    if signed_in?
      category = Category.find(params[:id])
      
      category.name = params[:name]
      category.description = params[:description]      
      category.save
      
      render json: :nothing, :status => 200
    else
      render json: "Guest can't update categories!", status: 401
    end
  end

  def destroy
    if signed_in?
      category = Category.find(params[:id])
      
      category.delete

      render json: :nothing, :status => 200      
     else
      render json: "Guest can't delete categories!", status: 401
    end
  end
end
