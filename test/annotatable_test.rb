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

    annotates with: :annotation
    def meth; end

    annotates with: :another_annotation1
    annotates with: :another_annotation2
    def another_meth; end
  end

  def setup
    A.include SimpleAnnotation::Annotatable
    B.include SimpleAnnotation::Annotatable
  end

  test 'include #annotates' do
    assert A.public_methods.include?(:annotates)
  end

  test 'include #annotated?' do
    assert A.public_methods.include?(:annotated?)
  end

  test 'A#meth1 is annotated' do
    A.annotates :meth1, with: :test1
    assert A.annotated?(:meth1)
  end

  test 'A#meth1 is annotated with test1' do
    A.annotates :meth1, with: :test1
    assert A.annotated?(:meth1, with: :test1)
  end

  test 'A#meth1 is annotated without test2' do
    A.annotates :meth1, with: :test1
    assert !A.annotated?(:meth1, with: :test2)
  end

  test 'A#meth2 is not annotated' do
    assert !A.annotated?(:meth2, with: :test)
  end

  test 'B#meth1 is not annotated' do
    assert !B.annotated?(:meth1, with: :test)
  end

  test 'A#meth1 is annotated with multiple annotations' do
    A.annotates :meth1, with: :annotation1
    A.annotates :meth1, with: :annotation2
    assert_equal A.annotations(:meth1), %i[annotation1 annotation2]
  end

  test 'Add annotation to multiple methods' do
    A.annotates :meth1, :meth2, with: :annotation
    assert A.annotated?(:meth1, with: :annotation)
    assert A.annotated?(:meth2, with: :annotation)
  end

  test 'A#meth is annotated with same annotations twice' do
    A.annotates :meth, with: :annotation
    A.annotates :meth, with: :annotation
    assert_equal A.annotations(:meth), %i[annotation]
  end

  test 'Annotate methods using separate style' do
    assert C.annotated?(:meth, with: :annotation)
  end

  test 'Annotate methods using separate style (multiple annotation)' do
    assert_equal C.annotations(:another_meth), %i[another_annotation1 another_annotation2]
  end
end
