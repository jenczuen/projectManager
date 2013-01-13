require 'spec_helper'

describe "Categories" do

  before do 
    @user=User.new

    @user.firstName="Michal"
    @user.secondName="Banasiak"
    @user.email="m.banasiak@aol.pl"
    @user.password="password"
    @user.password_confirmation="password"
    
    @user.save

    @category = Category.create(name: "Category", description: "Description")
  end

  describe "When user is a guest" do
    it "can get all categories" do
      get '/api/categories/all'

      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end

    it "can get one category" do
      get '/api/categories/get', { id: @category.id }

      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "can't create new category" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      response.status.should be(401)
      response.header['Content-Type'].should include 'application/json'
      puts response.body
    end

    it "can't update a category" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }

      response.status.should be(401)
      response.header['Content-Type'].should include 'application/json'
    end

    it "can't delete a category" do
      post '/api/categories/destroy', { id: @category.id }
      
      response.status.should be(401)
      response.header['Content-Type'].should include 'application/json'
    end
  end

  describe "When user is signed in" do
    before do 
      post '/api/signin', { e_mail: @user.email, password: @user.password }
    end

    it "can get all categories" do
      get '/api/categories/all'

      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end

    it "can get one category" do
      get '/api/categories/get', { id: @category.id }

      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "can create new category" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end

    it "can update a category" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }

      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end

    it "can delete a category" do
      post '/api/categories/destroy', { id: @category.id }
      
      response.status.should be(200)
      response.header['Content-Type'].should include 'application/json'
    end
  end

  after do
    post '/api/signout'
    @user.delete
    @category.delete
  end

end
