class PostsController < ApplicationController
  def getPosts
    posts = Post.all

    respond_to do |format|
      format.json { render json: posts }
    end
  end
end
