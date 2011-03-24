# This file is almost similar in structure to code1a.rb
# and code2b.rb but it's not identical as it has another method
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

  def his_name_length
    @his_name.length
  end
end