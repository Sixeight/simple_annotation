# frozen_string_literal: true

module MethodAnnotation
  module Annotatable
    def self.included(mod)
      mod.instance_variable_set(:@_method_to_annotations, Hash.new { |h, k| h[k] = [] })
      mod.extend ClassMethods
    end

    module ClassMethods
      def annotate_method(tag, *meths)
        Array(meths).each do |meth|
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
