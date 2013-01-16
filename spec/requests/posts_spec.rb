require 'spec_helper'

describe "Posts" do

  before do 
    User.delete_all
    Post.delete_all

    @user=User.new

    @user.firstName="Michal"
    @user.secondName="Banasiak"
    @user.email="m.banasiak@aol.pl"
    @user.password="password"
    @user.password_confirmation="password"
    
    @user.save
    
    @post = Post.create(title: "Post", content: "Content.")
  end
  
  describe "When user is a guest" do
    it "can get all posts" do
      get '/api/posts/all'

      response.status.should be(200)
    end
    
    it "all posts format is json" do
      get '/api/posts/all'
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "returned all posts should be correct" do
      get '/api/posts/all'

      response.body.should eq(Post.all.to_json)
    end 
    
    it "can get one post" do
      get '/api/posts/get', { id: @post.id }
      
      response.status.should be(200)
    end
    
    it "one post format is json" do
      get '/api/posts/get', { id: @post.id }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "returned one post should be correct" do
      get '/api/posts/get', { id: @post.id }
      
      response.body.should eq(@post.to_json)
    end 
    
    it "can't create new post" do
      post '/api/posts/create', { title: "P", content: "C" }
      
      response.status.should be(401)
    end
    
    it "create post error should be json" do
      post '/api/posts/create', { title: "P", content: "C" }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "create post error message should be correct" do
      post '/api/posts/create', { title: "P", content: "C" }
      
      response.body.should include "Guest can't create new posts!"
    end
    
    it "when creating is not allowed, database counter shouldn't change" do
      post '/api/posts/create', { title: "P", content: "C" }

      Post.count.should be(1)
    end

    it "can't update a post" do
      post '/api/posts/update', { id: @post.id, title: "New Title", content: "New Content" }
      
      response.status.should be(401)
    end
    
    it "update post error should be json" do
      post '/api/posts/update', { id: @post.id, title: "New Title", content: "New Content" }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "update post error message should be correct" do
      post '/api/posts/update', { id: @post.id, title: "New Title", content: "New Content" }
      
      response.body.should include "Guest can't update posts!"
    end
    
    it "when updating is not allowed, database shouldn't change" do
      post '/api/posts/update', { id: @post.id, title: "New Title", content: "New Content" }

      Post.find(@post.id).title.should eq("Post")
      Post.find(@post.id).content.should eq("Content.")
    end

    it "can't delete a post" do
      post '/api/posts/destroy', { id: @post.id }
      
      response.status.should be(401)
    end
    
    it "delete post error should be json" do
      post '/api/posts/destroy', { id: @post.id }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "delete post error message should be correct" do
      post '/api/posts/destroy', { id: @post.id }
      
      response.body.should include "Guest can't delete posts!"
    end

    it "when deleting is not allowed, database counter shouldnt change" do
      post '/api/posts/destroy', { id: @post.id }

      Post.count.should be(1)
    end
  end
  
  describe "When user is signed in" do
    before do 
      post '/api/signin', { e_mail: @user.email, password: @user.password }
    end
    
        it "can get all posts" do
      get '/api/posts/all'

      response.status.should be(200)
    end
    
    it "all posts format is json" do
      get '/api/posts/all'
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "returned all posts should be correct" do
      get '/api/posts/all'

      response.status.should be(200)
    end
    
    it "after create, response format is json" do
      post '/api/posts/create', { title: "New Post", content: "content" }

      response.header['Content-Type'].should include 'application/json' 
    end

    it "creating post should increment posts counter" do
      post '/api/posts/create', { title: "New Post", content: "content" }

      Post.count.should be(2)
    end
    
    it "after create post, it should be in database" do
      post '/api/posts/create', { title: "New Post", content: "content" }

      post = Post.last

      post.title.should eq("New Post")
      post.content.should eq("content")
    end

    it "can update a post" do
      post '/api/posts/update', { id: @post.id, title: "Updated Title", content: "Updated description." }
      
      response.status.should be(200)
    end
    
    it "after update, response format is json" do
      post '/api/posts/update', { id: @post.id, title: "Updated Title", content: "Updated description." }
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "after update, post should have new values" do
      post '/api/posts/update', { id: @post.id, title: "Updated Title", content: "Updated description." }
      
      Post.find(@post.id).title.should eq("Updated Title")
      Post.find(@post.id).content.should eq("Updated description.")
    end
    
    it "can delete a post" do
      post '/api/posts/destroy', { id: @post.id }
      
      response.status.should be(200)
    end
    
    it "after delete, response format is json" do 
      post '/api/posts/destroy', { id: @post.id }
      
      response.header['Content-Type'].should include 'application/json' 
    end
    
    it "deleting post should decrement posts counter" do
      post '/api/posts/destroy', { id: @post.id }

      Category.count.should be(0)
    end
  end
  
  after do
    post '/api/signout'

    User.delete_all
    Post.delete_all
  end
  
end
