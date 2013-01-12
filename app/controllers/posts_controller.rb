class PostsController < ApplicationController
  def all
    posts = Post.all

    respond_to do |format|
      format.json { render json: posts }
    end
  end

  def get
    post = Post.find(params[:id])

    respond_to do |format|
      format.json { render json: post }
    end
  end

  def create
    Post.create(title: params[:title],
                content: params[:content])

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
  
  def update
    post = Post.find(params[:id])

    post.title = params[:title]
    post.content = params[:content]

    post.save

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

  def destroy
    post = Post.find(params[:id])

    post.delete

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end  
end
