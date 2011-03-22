require "ripper"
require "pp"

sample_source = <<-EOS
  class Person
    def initialize(name)
      @name = name
    end

    def first_name
      @name.split(" ")[0]
    end

    def last_name
      @name.split(" ")[1]
    end
  end
EOS

sample_source_2 = <<-EOS
  # A comment that will be ignored
  # by the parser
  class Guy
    def initialize(his_name)
      @his_name       = his_name
    end

    def his_first_name

      @his_name.split(" ")[0] # this comment is also ignored

    end

    def his_last_name

      @his_name.split(" ")[1] # and so is this one

    end
  end
EOS

pp Ripper::SexpBuilder.new(sample_source).parse
puts "\n###########################\n\n"
pp Ripper::SexpBuilder.new(sample_source_2).parse