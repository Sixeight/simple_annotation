# MethodAnnotation

Annotate method with anything. Symbol, String and so on.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'method_annotation'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install method_annotation

## Usage

### Basic Style

```ruby
class A
  include MethodAnnotation::Annotatable

  def meth; end
end

# Annotate method with :annotation
A.annotate_method(:annotation, :meth)

A.method_annotated?(:annotation, :meth) #=> true
A.annotations_for(:meth) #=> [:annotation]
```

### Separate line Style

```ruby
class A
  include MethodAnnotation::Annotatable

  annotate_method 'this is a annotation'
  def meth; end
end

A.method_annotated?('this is a annotation', :meth) #=> true
A.annotations_for(:meth) #=> ['this is a annotation']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sixeight/method_annotation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
