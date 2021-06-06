# frozen_string_literal: true

require 'test_helper'

class AnnotationTest < Test::Unit::TestCase
  test 'annotation has name' do
    annotation = MethodAnnotation::Annotation.new(:annotation_name)
    assert_equal(annotation.name, :annotation_name)
  end

  test 'annotation has description' do
    annotation = MethodAnnotation::Annotation.new(:annotation_name, 'description')
    assert_equal(annotation.description, 'description')
  end
end
