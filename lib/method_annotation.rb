# frozen_string_literal: true

require_relative "method_annotation/version"
require_relative "method_annotation/annotation"
require_relative "method_annotation/annotatable"

module MethodAnnotation
  def annotations
    return [] unless owner.singleton_class.include? Annotatable
    owner.annotations_for(self.original_name)
  end

  ::UnboundMethod.include self
  ::Method.include self
end
