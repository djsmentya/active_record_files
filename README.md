# ActiveRecordFiles

Gem implement active record patern. It store data into json files.
Each file represent a model. File is a plain json text in format:

NOTICE: this gem not published to rubygems as it is for personal
researches.

```
store/users.json
[
  {name: 'John', email: 'john@example.com'}
]
```

## Installation

Install it yourself as:

    $ gem build active_record_files.gemspec
    $ gem install ./active_record_files-0.1.0.gem

## Usage

```ruby
require 'active_record_files'

ActiveRecordFiles::Base.configurations = {
  root: Pathname('/my/custome/path/to/root/directory')
}
class User < ActiveRecordFiles::Base
  # map attributes
  attribute :first_name, String
  attribute :last_name,  String
  attribute :email,      String
end

user = User.new first_name: 'John'
user.last_name = 'Doue'

user.save

User.create( first_name: 'Elis', email: 'elis@example.com')

john = User.find(0)
elis = User.find(1)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/djsmentya/active_record_files. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveRecordFiles project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_record_files/blob/master/CODE_OF_CONDUCT.md).
