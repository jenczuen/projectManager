require 'spec_helper'

describe "Post model" do

  before do
    @post=Post.new

    @post.title="Post"
    @post.content="Content of post."
  end
  
  subject { @post }

  describe "should have proper accessor methods" do
    it { should respond_to(:title) }
    it { should respond_to(:content) } 

    it { should respond_to(:user) }
    it { should respond_to(:category ) }
  end
  
  describe "data validation" do
    
    describe "when all data is present" do
      it { should be_valid }
    end
    
    describe "when title is not present" do
      before { @post.title = " " }
      it { should_not be_valid }
    end
    
    describe "when content is not present" do
      before { @post.content = " " }
      it { should_not be_valid }
    end
    
  end
  
end
