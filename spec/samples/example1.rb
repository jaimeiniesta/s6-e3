require 'ripper'

class DemoBuilder < Ripper::SexpBuilder
  def on_int(token) # scanner event
    super.tap { |result| p result }
  end

  def on_binary(left, operator, right) # parser event
    super.tap { |result| p result }
  end
end

src = "1 + 1"
DemoBuilder.new(src).parse