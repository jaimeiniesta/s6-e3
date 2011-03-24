# -*- encoding: utf-8 -*-

require_relative 'spec_helper'

describe SCompare::Simplifier do
  it "should simplify all strings" do
    code     = ['hello', "world"]
    expected = ['string', 'string']
    SCompare::Simplifier.simplify(code).should == expected
  end

  it "should simplify all fixnums" do
    code      = [1,2,3,100]
    expected  = [1,1,1,1]
    SCompare::Simplifier.simplify(code).should == expected
  end

  it "should leave unchanges symbols" do
    code      = [:a, :b, :c]
    expected  = [:a, :b, :c]
    SCompare::Simplifier.simplify(code).should == expected
  end

  it "should simplify an array with strings, fixnums and symbols" do
    code      = ['Jaime', :is, 38]
    expected  = ['string', :is, 1]
    SCompare::Simplifier.simplify(code).should == expected
  end

  it "should simplify nested arrays recursively" do
    code      = [38, 'elephants', [:work, 'together', [2,3]]]
    expected  = [1, 'string', [:work, 'string', [1,1]]]
    SCompare::Simplifier.simplify(code).should == expected
  end
end
