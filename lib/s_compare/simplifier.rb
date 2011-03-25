# -*- encoding: utf-8 -*-

module SCompare
  ##
  # SCompare::Simplifier is used to substitute values on parsed s-expressions,
  # substituting strings and fixnums and leaving other elements unchanged
  # so they can be later compared attending to its structure
  module Simplifier
    extend self

    ##
    # Accepts a nested array and returns it a copy of it with all strings and
    # fixnums replaced by simplified versions ('string' for each string, and
    # 1 for each fixnum)
    def simplify(scode)
      scode.map { |elem| replacement(elem) }
    end

    private

    def replacement(elem)
      case elem.class.to_s
      when 'String' then :simplifies_to_string
      when 'Fixnum' then :simplifies_to_numeric
      when 'Array' then simplify(elem)
      else elem
      end
    end
  end
end
