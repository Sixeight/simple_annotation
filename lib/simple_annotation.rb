# frozen_string_literal: true

require_relative 'simple_annotation/version'
require_relative 'simple_annotation/annotation'
require_relative 'simple_annotation/annotatable'

module SimpleAnnotation
  def annotations
    return [] unless owner.include? Annotatable

    owner.annotations_for(original_name)
  end

  ::UnboundMethod.include self
  ::Method.include self
end
