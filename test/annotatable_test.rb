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

  class C
    include SimpleAnnotation::Annotatable

    annotate_method :annotation
    def meth; end

    annotate_method :another_annotation1
    annotate_method :another_annotation2
    def another_meth; end
  end

  def setup
    A.include SimpleAnnotation::Annotatable
    B.include SimpleAnnotation::Annotatable
  end

  test 'include #annotate_method' do
    assert A.public_methods.include?(:annotate_method)
  end

  test 'include #annotated?' do
    assert A.public_methods.include?(:annotated?)
  end

  test 'A#meth1 is annotated with test1' do
    A.annotate_method :test1, :meth1
    assert A.annotated?(:meth1, with: :test1)
  end

  test 'A#meth1 is annotated without test2' do
    A.annotate_method :test1, :meth1
    assert !A.annotated?(:meth1, with: :test2)
  end

  test 'A#meth2 is not annotated' do
    assert !A.annotated?(:meth2, with: :test)
  end

  test 'B#meth1 is not annotated' do
    assert !B.annotated?(:meth1, with: :test)
  end

  test 'A#meth1 is annotated with multiple annotations' do
    A.annotate_method :annotation1, :meth1
    A.annotate_method :annotation2, :meth1
    assert_equal A.annotations(:meth1), %i[annotation1 annotation2]
  end

  test 'Add annotation to multiple methods' do
    A.annotate_method :annotation, :meth1, :meth2
    assert A.annotated?(:meth1, with: :annotation)
    assert A.annotated?(:meth1, with: :annotation)
  end

  test 'A#meth is annotated with same annotations twice' do
    A.annotate_method :annotation, :meth
    A.annotate_method :annotation, :meth
    assert_equal A.annotations(:meth), %i[annotation]
  end

  test 'Annotate methods using separate style' do
    assert C.annotated?(:meth, with: :annotation)
  end

  test 'Annotate methods using separate style (multiple annotation)' do
    assert_equal C.annotations(:another_meth), %i[another_annotation1 another_annotation2]
  end
end
