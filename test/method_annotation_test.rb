# frozen_string_literal: true

require 'test_helper'

class SimpleAnnotationTest < Test::Unit::TestCase
  test 'VERSION' do
    assert do
      ::SimpleAnnotation.const_defined?(:VERSION)
    end
  end

  class A
    def meth; end
  end

  class B
    def meth; end
  end

  def setup
    A.include SimpleAnnotation::Annotatable
  end

  test 'A#meth is annotated with multiple annotations (unbound method)' do
    A.annotate_method :annotation1, :meth
    A.annotate_method :annotation2, :meth
    unbound_meth = A.public_instance_method(:meth)
    assert_equal unbound_meth.annotations, %i[annotation1 annotation2]
  end

  test 'A#meth is annotated with multiple annotations (method)' do
    A.annotate_method :annotation1, :meth
    A.annotate_method :annotation2, :meth
    meth = A.new.public_method(:meth)
    assert_equal meth.annotations, %i[annotation1 annotation2]
  end

  test 'A#meth is not annotated (unbound method)' do
    meth = A.public_instance_method(:meth)
    assert_equal meth.annotations, []
  end

  test 'A#meth is not annotated (method)' do
    meth = A.new.public_method(:meth)
    assert_equal meth.annotations, []
  end

  test 'B is not included annotatable (unbound method)' do
    meth = B.public_instance_method(:meth)
    assert_equal meth.annotations, []
  end

  test 'B is not included annotatable (method)' do
    meth = B.new.public_method(:meth)
    assert_equal meth.annotations, []
  end
end
