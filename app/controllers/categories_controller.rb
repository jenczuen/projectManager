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
      
      format.all { render :nothing => true, :status => 200 }
    else
      render json: "Guests cannot create new categories!", status: 401
    end
  end
  
  def update
    name   = params[:name]
    description = params[:description]
        
    category = Category.find(params[:id])

    category.name = name
    category.description = description

    category.save

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

  def destroy
    category = Category.find(params[:id])

    category.delete

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
end
