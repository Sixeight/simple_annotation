# frozen_string_literal: true

require "test_helper"

class MethodAnnotationTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::MethodAnnotation.const_defined?(:VERSION)
    end
  end

  class A
    def meth; end
  end

  class B
    def meth; end
  end

  def setup
    A.extend MethodAnnotation::Annotatable
  end

  test 'A#meth is annotated with multiple tags (unbound method)' do
    A.annotate_method :tag1, :meth
    A.annotate_method :tag2, :meth
    unbound_meth = A.public_instance_method(:meth)
    assert_equal unbound_meth.annotations, [:tag1, :tag2]
  end

  test 'A#meth is annotated with multiple tags (method)' do
    A.annotate_method :tag1, :meth
    A.annotate_method :tag2, :meth
    meth = A.new.public_method(:meth)
    assert_equal meth.annotations, [:tag1, :tag2]
  end

  test 'A#meth is not annotated (unbound method)' do
    meth = A.public_instance_method(:meth)
    assert_equal meth.annotations, []
  end

  test 'A#meth is not annotated (method)' do
    meth = A.new.public_method(:meth)
    assert_equal meth.annotations, []
  end

  test 'B is not extend annotatable (unbound method)' do
    meth = B.public_instance_method(:meth)
    assert_equal meth.annotations, []
  end

  test 'B is not extend annotatable (method)' do
    meth = B.new.public_method(:meth)
    assert_equal meth.annotations, []
  end
end
