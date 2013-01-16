require 'spec_helper'

describe "Posts" do

  before do 
    User.delete_all

    @user=User.new

    @user.firstName="Michal"
    @user.secondName="Banasiak"
    @user.email="m.banasiak@aol.pl"
    @user.description="ios developer"
    @user.password="password"
    @user.password_confirmation="password"
    
    @user.save
  end
  
  describe "No matter if user is a guest or no" do
    it "he can get all users" do
      get '/api/users/all'

      response.status.should be(200)
    end
    
    it "all users format is json" do
      get '/api/users/all'
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "returned all users should be correct" do
      get '/api/users/all'

      response.body.should eq(User.all.to_json)
    end 
    
    it "can get one user" do
      get '/api/users/get', { id: @user.id }
      
      response.status.should be(200)
    end
    
    it "one user format is json" do
      get '/api/users/get', { id: @user.id }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "returned one user should be correct" do
      get '/api/users/get', { id: @user.id }
      
      response.body.should eq(@user.to_json)
    end 
  end
  
  describe "When user is a guest" do
    it "can create new user (register)" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
      response.status.should be(200)
    end
    
    it "after create, response format is json" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
      response.header['Content-Type'].should include 'application/json' 
    end
    
    it "creating user should increment posts counter" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
      User.count.should be(2)
    end
    
    it "after create an user, he should be in database" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
      user = User.last

      user.firstName.should eq("Jedrek")
      user.secondName.should eq("Siemienski")
      user.email.should eq("jenczuen@gmail.com")
    end

    it "can't update an user" do
      post '/api/users/update', {
        id: @user.id,
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
      response.status.should be(401)
    end
    
    it "update user error should be json" do
      post '/api/users/update', {
        id: @user.id,
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }

      response.header['Content-Type'].should include 'application/json'
    end
    
    it "update user error message should be correct" do
      post '/api/users/update', {
        id: @user.id,
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }

      response.body.should include "Guest can't update users!"
    end
    
    it "when updating is not allowed, database shouldn't change" do
      post '/api/users/update', {
        id: @user.id,
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }

      User.find(@user.id).firstName should eq("Michal")
      User.find(@user.id).secondName should eq("Banasiak")
      User.find(@user.id).email should eq("m.banasiak@aol.pl")
    end

    it "can't delete any user" do
      post '/api/users/destroy', { id: @user.id }
      
      response.status.should be(401)
    end
    
    it "delete user error should be json" do
      post '/api/users/destroy', { id: @user.id }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "delete user error message should be correct" do
      post '/api/users/destroy', { id: @user.id }
      
      response.body.should include "Guest can't delete users!"
    end

    it "when deleting is not allowed, database counter shouldnt change" do
      post '/api/users/destroy', { id: @user.id }

      User.count.should be(1)
    end
  end
  
  describe "When user is signed in" do
    before do 
      post '/api/signin', { e_mail: @user.email, password: @user.password }
    end
    
    it "can't create new user (register)" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
        response.status.should be(401)
    end
    
    it "create user error should be json" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
      
      response.header['Content-Type'].should include 'application/json'
    end
    
    it "create user error message should be correct" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
            
      response.body.should include "You have to sign out to register new users!"
    end
    
    it "when creating is not allowed, database counter shouldn't change" do
      post '/api/users/create', { 
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com",
        password: "ulicznywstrzas",
        password_confirmation: "ulicznywstrzas"
      }
            
      User.count.should be(1)
    end

    it "can update himself" do
      post '/api/users/update', {
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com"
      }
      
      response.status.should be(200)
    end
    
    it "after update, response format is json" do
      post '/api/users/update', {
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com"
      }
      
      response.header['Content-Type'].should include 'application/json' 
    end

    it "after update, user should have new data" do
      post '/api/users/update', {
        first_name: "Jedrek", 
        second_name: "Siemienski",
        email: "jenczuen@gmail.com"
      }
      
      User.find(@user.id).firstName.should eq("Jedrek")
      User.find(@user.id).secondName.should eq("Siemienski")
      User.find(@user.id).email.should eq("jenczuen@gmail.com")
    end
    
    it "can delete himself(unregister)" do
      post '/api/users/destroy'
      
      response.status.should be(200)
    end
    
    it "after delete, response format is json" do 
      post '/api/users/destroy'
      
      response.header['Content-Type'].should include 'application/json' 
    end
    
    it "deleting user should decrement users counter" do
      post '/api/users/destroy'

      Category.count.should be(0)
    end
  end
  
  after do
    post '/api/signout'

    User.delete_all
  end
  
end
