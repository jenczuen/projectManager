require 'spec_helper'

describe "Authentications" do
  before do 
    @user=User.new

    @user.firstName="Michal"
    @user.secondName="Banasiak"
    @user.email="m.banasiak@aol.pl"
    @user.password="password"
    @user.password_confirmation="password"

    @user.save
  end

  describe "When user sign" do
    it "and the user exists" do
      post '/api/signin', { e_mail: "m.banasiak@aol.pl", password: "password" }
    
      response.status.should be(200)
    end
    it "and the user don't exists" do
      post '/api/signin', { e_mail: "m.banasiak2@aol.pl", password: "password" }
      
      response.status.should be(401)
    end
    it "and the user exists but password is wrong" do
      post '/api/signin', { e_mail: "m.banasiak@aol.pl", password: "password2" }
    
      response.status.should be(401)
    end

  end
  
  after do
    post "/api/signout"
    @user.delete
  end

end
