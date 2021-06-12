# frozen_string_literal: true

require 'set'

module SimpleAnnotation
  module Annotatable
    def self.included(mod)
      mod.instance_variable_set(:@__method_to_annotations, Hash.new { |h, k| h[k] = Set.new })
      mod.instance_variable_set(:@__standby_annotations, [])
      mod.extend ClassMethods
    end

    module ClassMethods
      def annotates(*methods, with:)
        @__standby_annotations << with if methods.length <= 0

        methods.each do |meth|
          @__method_to_annotations[meth.to_sym] << with
        end
      end

      def annotated?(meth, with: nil)
        return @__method_to_annotations[meth.to_sym].include?(with) unless with.nil?

        @__method_to_annotations.include? meth.to_sym
      end

      def annotations(meth)
        @__method_to_annotations[meth.to_sym].to_a
      end

      private

      def method_added(meth)
        super

        @__standby_annotations.each do |annotation|
          annotates meth, with: annotation
        end
        @__standby_annotations.clear
      end
    end
  end
end
