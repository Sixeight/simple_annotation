# frozen_string_literal: true

require "test_helper"

class MethodAnnotationTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::MethodAnnotation.const_defined?(:VERSION)
    end
  end
end
