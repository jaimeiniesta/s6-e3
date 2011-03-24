# A comment that will be ignored
# by the parser.
# This file is similar in structure to code1a.rb
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