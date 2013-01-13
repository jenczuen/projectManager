require 'spec_helper'

describe "User model" do

  before do
    @user.firstName="Michal"
    @user.secondName="Banasiak"
    email="m.banasiak@aol.pl"
    @user.password="password"
    @user.password_confirmation="password"
  end
  
  subject { @user }

  describe "should have proper accessor methods" do
    it { should respond_to(:firstName) }
    it { should respond_to(:secondName) }
    it { should respond_to(:email) }
    it { should respond_to(:description) } 
    it { should respond_to(:password_digest) } 
    it { should respond_to(:password) } 
    it { should respond_to(:password_confirmation) } 
  end

  describe "data validation" do
    
    describe "when all data is present" do
      it { should be_valid }
    end

    describe "when first name is not present" do
      before { @user.firstName = " " }
      it { should_not be_valid }
    end
    
    describe "when second name is not present" do
      before { @user.secondName = " " }
      it { should_not be_valid }
    end

    describe "when email is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end
    
    describe "when password is not present" do
      before { @user.password = @user.password_confirmation = " " }
      it { should_not be_valid }
    end
    
    describe "when email format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          it { should_not be_valid }
        end      
      end
    end
    
    describe "when email format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          it { should be_valid }
        end      
      end
    end
  
    describe "when email address is already taken" do
      before do
        @user_with_same_email = @user.dup
        @user_with_same_email.email = @user.email.upcase
        @user_with_same_email.save
      end
      
      it { should_not be_valid }

      after do
        @user_with_same_email.delete 
      end
    end
  
    describe "when password doesn't match confirmation" do
      before { @user.password_confirmation = "mismatch" }
      it { should_not be_valid }
    end
    
    describe "when password confirmation is nil" do
      before { @user.password_confirmation = nil }
      it { should_not be_valid }
    end    
    
    describe "when a password is too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  end
  
  describe "authentication" do
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email) }
      
      describe "with valid password" do
        it { should == found_user.authenticate(@user.password) }
      end
      
      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }
        
        it { should_not == user_for_invalid_password }
        specify { user_for_invalid_password.should be_false }
      end
    end
  end
  
end

