# SimpleAnnotation

Annotate method with anything. Symbol, String and so on.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_annotation'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simple_annotation

## Usage

### Basic style

```ruby
class A
  include SimpleAnnotation::Annotatable

  def meth; end
end

A.annotated?(:meth) #=> false

# Annotate method with :example
A.annotates(:meth, with: :example)

A.annotated?(:meth, with: :example) #=> true
A.annotations(:meth) #=> [:example]

A.public_instance_method(:meth).annotations #=> [:example]
A.new.method(:meth).annotations #=> [:example]
```

### Separate line style

```ruby
class A
  include SimpleAnnotation::Annotatable

  annotates 'this is a annotation'
  def meth; end
end

A.annotated?(:meth, with: 'this is a annotation') #=> true
A.annotations(:meth) #=> ['this is a annotation']

A.public_instance_method(:meth).annotations #=> ['this is a annotation']
A.new.method(:meth).annotations #=> ['this is a annotation']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Sixeight/simple_annotation.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
