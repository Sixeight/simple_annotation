# frozen_string_literal: true

module MethodAnnotation
  class Annotation
    attr_reader :name, :description

    def initialize(name, description = '')
      @name = name
      @description = description
    end
  end
end
