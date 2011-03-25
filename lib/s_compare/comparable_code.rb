# -*- encoding: utf-8 -*-

require "ripper"

module SCompare
  ##
  # A ComparableCode instance accepts a chunk of Ruby code as a string
  # and provides a simplified version of it, parsing its structure and
  # replacing strings and fixnums by fixed values.
  #
  # It also implements equality comparations, so you can easily compare
  # two Ruby codes for similarities. For example:
  #
  # ComparableCode.new("def foo; x = 1; end") == ComparableCode.new("def bar; y = 1; end")
  #
  class ComparableCode
    def initialize(code)
      @code             = code
    end

    ##
    # Parses the s-expression of the code and returns a simplified version
    def simplified_code
      simplify(structure(@code))
    end

    ##
    # Equality comparison based on the simplified structure
    def ==(other)
      simplified_code == other.simplified_code
    end

    private

    # Parses the s-expression for this code
    def structure(code)
      Ripper::SexpBuilder.new(code).parse
    end

    ##
    # Simplifies a code structure replacing its elements
    def simplify(scode)
      scode.map { |elem| replacement(elem) }
    end

    ##
    # Provides a replacement for an element based on its class
    # strings and fixnums will be replaced by a symbol
    # and arrays will be recursively replaced
    # Other kind of elements will remain untouched
    def replacement(elem)
      case elem.class.to_s
      when 'String' then :simplified_value
      when 'Array' then intercept_coordinates(elem)
      else elem
      end
    end

    ##
    # If an elem is an array with two fixnums, it looks like s-expression
    # coordinates and it's replaced by its symbol. If not, a recursive
    # simplification is called for this element
    def intercept_coordinates(elem)
      if (elem.length == 2 && elem[0].kind_of?(Fixnum) && elem[1].kind_of?(Fixnum))
        :simplified_coordinates
      else
        simplify(elem)
      end
    end
  end
end