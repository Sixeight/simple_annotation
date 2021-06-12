# frozen_string_literal: true

module SimpleAnnotation
  class Annotation
    attr_reader :name, :description

    def initialize(name, description = '')
      @name = name
      @description = description
    end
  end
end
