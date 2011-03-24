require_relative 'spec_helper'

describe SCompare::Comparator do
  before(:each) do
    @code1a = File.open(File.dirname(__FILE__)+'/samples/code1a.rb', 'r').read
    @code1b = File.open(File.dirname(__FILE__)+'/samples/code1b.rb', 'r').read
    @code1c = File.open(File.dirname(__FILE__)+'/samples/code1c.rb', 'r').read
  end

  it "should tell a code is equal to itself" do
    SCompare::Comparator.same_structure?(@code1a, @code1a).should == true
  end

  it "should tell a code is equal to another with same structure" do
    SCompare::Comparator.same_structure?(@code1a, @code1b).should == true
  end

  it "should have a commutative property, a == b and b == a" do
    SCompare::Comparator.same_structure?(@code1b, @code1a).should == true
  end

  it "should tell a code is different from another with different structure" do
    SCompare::Comparator.same_structure?(@code1a, @code1c).should == false
  end
end