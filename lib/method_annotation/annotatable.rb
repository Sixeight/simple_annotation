# frozen_string_literal: true

module MethodAnnotation
  module Annotatable
    def self.included(mod)
      mod.instance_variable_set(:@_method_to_annotations, Hash.new { |h, k| h[k] = [] })
      mod.instance_variable_set(:@__standby_annotations, [])
      mod.extend ClassMethods
    end


    module ClassMethods
      def method_added(meth)
        return if @__standby_annotations.length < 1
        annotation = @__standby_annotations.shift
        annotate_method annotation, meth
      end

      def annotate_method(tag, *methods)
        if methods.length <= 0
          @__standby_annotations << tag
          return
        end

        methods.each do |meth|
          @_method_to_annotations[meth.to_sym] << tag
        end
      end

      def method_annotated?(tag, meth)
        @_method_to_annotations[meth.to_sym].include? tag
      end

      def annotations_for(meth)
        @_method_to_annotations[meth.to_sym].clone
      end
    end
  end
end
