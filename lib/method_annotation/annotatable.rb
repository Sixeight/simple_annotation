# frozen_string_literal: true

module MethodAnnotation
  module Annotatable
    def self.included(mod)
      mod.instance_variable_set(:@__method_to_annotations, Hash.new { |h, k| h[k] = Set.new })
      mod.instance_variable_set(:@__standby_annotations, [])
      mod.extend ClassMethods
    end

    module ClassMethods
      def method_added(meth)
        super

        @__standby_annotations.each do |annotation|
          annotate_method annotation, meth
        end
        @__standby_annotations.clear
      end

      def annotate_method(annotation, *methods)
        @__standby_annotations << annotation if methods.length <= 0

        methods.each do |meth|
          @__method_to_annotations[meth.to_sym] << annotation
        end
      end

      def method_annotated?(annotation, meth)
        @__method_to_annotations[meth.to_sym].include? annotation
      end

      def annotations_for(meth)
        @__method_to_annotations[meth.to_sym].to_a
      end
    end
  end
end
