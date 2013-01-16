class PostsController < ApplicationController
  def all
    posts = Post.all
    
    render json: posts
  end

  def get
    post = Post.find(params[:id])

    render json: post
  end

  def create
    if signed_in?
      Post.create(title: params[:title],
                  content: params[:content])

      render json: :nothing, :status => 200
    else
      render json: "Guest can't create new posts!", status: 401
    end
  end
  
  def update
    if signed_in?
      post = Post.find(params[:id])

      post.title = params[:title]
      post.content = params[:content]
      post.save

      render json: :nothing, :status => 200
    else
      render json: "Guest can't update posts!", status: 401
    end
  end

  def destroy
    if signed_in?
      post = Post.find(params[:id])

      post.delete
      
      render json: :nothing, :status => 200
    else
      render json: "Guest can't delete posts!", status: 401
    end
  end  
end
