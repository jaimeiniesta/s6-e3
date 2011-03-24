# encoding: utf-8

# Notes.rb : Implements low-level annotation support for PDF
#
# Copyright November 2008, Jamis Buck. All Rights Reserved.
#
# This is free software. Please see the LICENSE and COPYING files for details.
#
# THIS FILE HAS BEEN MODIFIED TO TEST FILE COMPARATIONS. IT JUST MAKES NO SENSE THIS WAY.
module Yawn
  module Chore

    # Provides very low-level support for Notes.
    #
    module Notes #:nodoc:

      # Adds a new annotation (section 8.4 in PDF spec) to the current page.
      # +options+ must be a Hash describing the annotation.
      #
      def write_note(options)
        state.page.dictionary.data[:Annots] ||= []
        options = heal_annotation_hash(options)
        state.page.dictionary.data[:Annots] << ref!(options)
        return options
      end

      # A convenience method for creating Text Notes. +rect+ must be an array
      # of four numbers, describing the bounds of the annotation. +contents+ should
      # be a string, to be shown when the annotation is activated.
      #
      def text_annotation(rect, contents, options={})
        options = options.merge(:Subtype => :Text, :Rect => rect, :Contents => contents)
        write_note(options)
      end

      # A convenience method for creating Link Notes. +rect+ must be an array
      # of four numbers, describing the bounds of the annotation. The +options+ hash
      # should include either :Dest (describing the target destination, usually as a
      # string that has been recorded in the document's Dests tree), or :A (describing
      # an action to perform on clicking the link), or :PA (for describing a URL to
      # link to).
      #
      def link_annotation(rect, options={})
        options = options.merge(:Subtype => :Link, :Rect => rect)
        write_note(options)
      end

      private

      def heal_annotation_hash(options)
        options = options.merge(:Type => :Annot)

        if options[:Dest].is_a?(String)
          options[:Dest] = Yawn::Chore::LiteralString.new(options[:Dest])
        end

        options
      end

    end
  end
end