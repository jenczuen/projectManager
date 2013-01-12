class CategoriesController < ApplicationController
  def all
    categories = Category.all

    puts current_user.eMail

    respond_to do |format|
      format.json { render json: categories }
    end
  end

  def get
    category = Category.find(params[:id])

    respond_to do |format|
      format.json { render json: category }
    end
  end

  def create
    name   = params[:name]
    description = params[:description]
    
    Category.create(name:        name,
                    description: description)

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
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
