# frozen_string_literal: true

module MethodAnnotation
  module Annotatable
    def self.extended(mod)
      mod.class_variable_set(:@@method_to_annotations, Hash.new { |h, k| h[k] = [] })
    end

    def annotate_method(tag, meth)
      class_variable_get(:@@method_to_annotations)[meth.name] << tag
    end

    def method_annotated?(tag, meth)
      class_variable_get(:@@method_to_annotations)[meth.name].include? tag
    end

    def annotations_for(meth)
      class_variable_get(:@@method_to_annotations)[meth.name].clone
    end
  end
end
