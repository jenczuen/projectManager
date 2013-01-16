require 'spec_helper'

describe "Categories" do

  before do 
    User.delete_all
    Category.delete_all

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
    end
    
    it "all categories format is json" do
      get '/api/categories/all'
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "returned all categories should be correct" do
      get '/api/categories/all'

      response.body.should eq(Category.all.to_json)
    end 
    
    it "can get one category" do
      get '/api/categories/get', { id: @category.id }
      
      response.status.should be(200)
    end
    
    it "one category format is json" do
      get '/api/categories/get', { id: @category.id }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "returned one category should be correct" do
      get '/api/categories/get', { id: @category.id }
      
      response.body.should eq(@category.to_json)
    end 
    

    it "can't create new category" do
      post '/api/categories/create', { name: "Cat", description: "desc" }
      
      response.status.should be(401)
    end
    
    it "create category error should be json" do
      post '/api/categories/create', { name: "Cat", description: "desc" }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "create category error message should be correct" do
      post '/api/categories/create', { name: "Cat", description: "desc" }
      
      response.body.should include "Guest can't create new categories!"
    end
    
    it "when creating is not allowed, database counter shouldn't change" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      Category.count.should be(1)
    end

    it "can't update a category" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }
      
      response.status.should be(401)
    end
    
    it "update category error should be json" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "update category error message should be correct" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }
      
      response.body.should include "Guest can't update categories!"
    end
    
    it "when updating is not allowed, database shouldn't change" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }

      Category.find(@category.id).name.should eq("Category")
      Category.find(@category.id).description.should eq("Description")
    end

    it "can't delete a category" do
      post '/api/categories/destroy', { id: @category.id }
      
      response.status.should be(401)
    end
    
    it "delete category error should be json" do
      post '/api/categories/destroy', { id: @category.id }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "delete category error message should be correct" do
      post '/api/categories/destroy', { id: @category.id }
      
      response.body.should include "Guest can't delete categories!"
    end

    it "when deleting is not allowed, database counter shouldnt change" do
      post '/api/categories/destroy', { id: @category.id }

      Category.count.should be(1)
    end
  end
  
  describe "When user is signed in" do
    before do 
      post '/api/signin', { e_mail: @user.email, password: @user.password }
    end
    
    it "can get all categories" do
      get '/api/categories/all'
      
      response.status.should be(200)
    end
    
    it "all categories format is json" do
      get '/api/categories/all'
      
      response.header['Content-Type'].should include 'application/json' 
    end
    
    it "can get one category" do
      get '/api/categories/get', { id: @category.id }
      
      response.status.should be(200)
    end
    
    it "one category format is json" do
      get '/api/categories/get', { id: @category.id }
      
      response.header['Content-Type'].should include 'application/json' 
    end
    
    it "can create new category" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      response.status.should be(200)
    end
    
    it "after create, response format is json" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      response.header['Content-Type'].should include 'application/json' 
    end

    it "creating category should increment categories counter" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      Category.count.should be(2)
    end
    
    it "after create category, it should be in database" do
      post '/api/categories/create', { name: "Cat", description: "desc" }

      category = Category.last

      category.name.should eq("Cat")
      category.description.should eq("desc")
    end

    it "can update a category" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }
      
      response.status.should be(200)
    end
    
    it "after update, response format is json" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "after update, category should have new values" do
      post '/api/categories/update', { id: @category.id, name: "Cat", description: "desc" }

      Category.find(@category.id).name.should eq("Cat")
      Category.find(@category.id).description.should eq("desc")
    end
    
    it "can delete a category" do
      post '/api/categories/destroy', { id: @category.id }
      
      response.status.should be(200)
    end
    
    it "after delete, response format is json" do 
      post '/api/categories/destroy', { id: @category.id }
      
      response.header['Content-Type'].should include 'application/json' 
    end
    
    it "deleting category should decrement categories counter" do
      post '/api/categories/destroy', { id: @category.id }

      Category.count.should be(0)
    end
  end
  
  after do
    post '/api/signout'

    User.delete_all
    Category.delete_all
  end
  
end
