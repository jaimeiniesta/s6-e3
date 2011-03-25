require_relative 'spec_helper'

describe SCompare::ComparableCode do
  before(:each) do
    code1a = File.open(File.dirname(__FILE__)+'/samples/code1a.rb', 'r').read
    code1b = File.open(File.dirname(__FILE__)+'/samples/code1b.rb', 'r').read
    code1c = File.open(File.dirname(__FILE__)+'/samples/code1c.rb', 'r').read

    @comparable1a = SCompare::ComparableCode.new(code1a)
    @comparable1b = SCompare::ComparableCode.new(code1b)
    @comparable1c = SCompare::ComparableCode.new(code1c)
  end

  context "Comparations" do
    it "should tell a code is equal to itself" do
      @comparable1a.should == @comparable1a
    end

    it "should tell a code is equal to another with same structure" do
      @comparable1a.should == @comparable1b
    end

    it "should have a commutative property, a == b and b == a" do
      @comparable1b.should == @comparable1a
    end

    it "should tell a code is different from other with different structure" do
      @comparable1a.should_not == @comparable1c
    end
  end

  context "Code simplification" do
    it "should simplify all strings" do
      code     = "['hello', 'world']"
      expected = [:program, [:stmts_add, [:stmts_new], [:array, [:args_add, [:args_add, [:args_new], [:string_literal, [:string_add, [:string_content], [:@tstring_content, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:string_literal, [:string_add, [:string_content], [:@tstring_content, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]]]]]
      SCompare::ComparableCode.new(code).simplified_code.should == expected
    end

    it "should simplify all fixnums" do
      code      = "[1,2,3,100]"
      expected  = [:program, [:stmts_add, [:stmts_new], [:array, [:args_add, [:args_add, [:args_add, [:args_add, [:args_new], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]]]
      SCompare::ComparableCode.new(code).simplified_code.should == expected
    end

    it "should leave unchanges symbols" do
      code      = "[:a, :b, :c]"
      expected  = [:program, [:stmts_add, [:stmts_new], [:array, [:args_add, [:args_add, [:args_add, [:args_new], [:symbol_literal, [:symbol, [:@ident, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:symbol_literal, [:symbol, [:@ident, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:symbol_literal, [:symbol, [:@ident, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]]]]]
      SCompare::ComparableCode.new(code).simplified_code.should == expected
    end

    it "should simplify an array with strings, fixnums and symbols" do
      code      = "['Jaime', :is, 38]"
      expected  = [:program, [:stmts_add, [:stmts_new], [:array, [:args_add, [:args_add, [:args_add, [:args_new], [:string_literal, [:string_add, [:string_content], [:@tstring_content, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:symbol_literal, [:symbol, [:@ident, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]]]
      SCompare::ComparableCode.new(code).simplified_code.should == expected
    end

    it "should simplify nested arrays recursively" do
      code      = "[38, 'elephants', [:work, 'together', [2,3]]]"
      expected  = [:program, [:stmts_add, [:stmts_new], [:array, [:args_add, [:args_add, [:args_add, [:args_new], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]], [:string_literal, [:string_add, [:string_content], [:@tstring_content, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:array, [:args_add, [:args_add, [:args_add, [:args_new], [:symbol_literal, [:symbol, [:@ident, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:string_literal, [:string_add, [:string_content], [:@tstring_content, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]], [:array, [:args_add, [:args_add, [:args_new], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]], [:@int, :simplifies_to_string, [:simplifies_to_numeric, :simplifies_to_numeric]]]]]]]]]]
      SCompare::ComparableCode.new(code).simplified_code.should == expected
    end
  end
end