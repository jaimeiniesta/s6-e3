# -*- encoding: utf-8 -*-

require "ripper"

module SCompare
  ##
  # SCompare::Comparator is used to compare 2 ruby codes,
  # parsing its s-expression and simplifying it
  # to be able to compare the subjacent structure
  module Comparator
    extend self

    # Compares 2 codes, parsing and simplifying its structure
    def same_structure?(code_a, code_b)
      simple_a = Simplifier.simplify(structure(code_a))
      simple_b = Simplifier.simplify(structure(code_b))

      simple_a == simple_b
    end

    private

    # Parses the s-expression for this code
    def structure(code)
      Ripper::SexpBuilder.new(code).parse
    end

  end
end