# frozen_string_literal: true

require 'test_helper'

class AnnotatableTest < Test::Unit::TestCase
  class A
    def meth1; end

    def meth2; end
  end

  class B
    def meth1; end
  end

  def setup
    A.include MethodAnnotation::Annotatable
    B.include MethodAnnotation::Annotatable
  end

  test 'include #annotate_method' do
    assert A.public_methods.include?(:annotate_method)
  end

  test 'include #method_annotated?' do
    assert A.public_methods.include?(:method_annotated?)
  end

  test 'A#meth1 is annotated with test1' do
    A.annotate_method :test1, :meth1
    assert A.method_annotated?(:test1, :meth1)
  end

  test 'A#meth1 is annotated without test2' do
    A.annotate_method :test1, :meth1
    assert !A.method_annotated?(:test2, :meth1)
  end

  test 'A#meth2 is not annotated' do
    assert !A.method_annotated?(:test, :meth2)
  end

  test 'B#meth1 is not annotated' do
    assert !B.method_annotated?(:test, :meth1)
  end

  test 'A#meth1 is annotated with multiple tags' do
    A.annotate_method :tag1, :meth1
    A.annotate_method :tag2, :meth1
    assert_equal A.annotations_for(:meth1), %i[tag1 tag2]
  end

  test 'Add tag to multiple methods' do
    A.annotate_method :tag, :meth1, :meth2
    assert A.method_annotated?(:tag, :meth1)
    assert A.method_annotated?(:tag, :meth2)
  end
end
