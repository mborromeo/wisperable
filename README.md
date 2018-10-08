# Wisperable

Get notified of any ActiveModel events using the [Wisper gem](https://github.com/krisleech/wisper).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wisperable', '~> 0.1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wisperable

## Usage

Add `import Wisperable::Model` to your models, and configure which events you want to listen for with `wisperable events: [:created, :updated, :destroyed]`

Let's see an example:
```ruby
class Account
  include Wisperable::Model
  wisperable events: [:created, :updated, :destroyed]
end
```

When any create, update or destroy event will happen on an instance of Account, a corresponding `account_created`, `account_updated` or `account_destroyed` will be broadcasted by Wisper.

You can customize the broadcasting key to be used:
```ruby
class Account
  include Wisperable::Model
  wisperable events: [:created, :updated, :destroyed], publish_key: 'user'
end
```

In this key, the broadcast message will be in the form of `user_created`, `user_updated` and `user_destroyed`.

##### Events parameters
`_created` event broadcasts one parameter with the created object.  
`_updated` event broadcasts two parameters with the updated object and the changed attributes.  
`_destroyed` event broadcasts one parameter with a copy of the destroyed model attribute. 

Please see the following example of a PORO (Plain Old Ruby Object) able to intercept Wisperable broadcasts:
```ruby
class AccountNotifier
  def account_created(account)
    # account has been created.
  end
  
  def account_updated(account, changes)
    # account has been updated. 
    # changes contains the changed attributes.
  end
  
  def account_destroyed(account)
    # account contains a copy of the destroyed Account model.
  end
end
```

Please see [Wisper](https://github.com/krisleech/wisper) for any other subscribers setup instruction.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mborromeo/wisperable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

If you want to contribute with a pull request please follow these steps:
  * Fork the project, create a new branch from `master`.
  * Squash commits which are related.
  * Write a good enough commit message.
  * Do not bump the VERSION, but do indicate in the pull request message if the change is not backwards compatible.
  * Issue a Pull Request

And... thanks for any contribution!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Wisperable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mborromeo/wisperable/blob/master/CODE_OF_CONDUCT.md).
