require 'spec_helper'

describe "Category model" do

  before do
    @category=Category.new

    @category.name="Category"
    @category.description="description of category."
  end
  
  subject { @category }

  describe "should have proper accessor methods" do
    it { should respond_to(:name) }
    it { should respond_to(:description) } 

    it { should respond_to(:users) }
    it { should respond_to(:posts) }
  end
  
  describe "data validation" do
    
    describe "when all data is present" do
      it { should be_valid }
    end
    
    describe "when name is not present" do
      before { @category.name = " " }
      it { should_not be_valid }
    end
    
    describe "when description is not present" do
      before { @category.description = " " }
      it { should_not be_valid }
    end
    
  end
  
end
