# Rspec Rails

Repo:
  `https://github.com/rspec/rspec-rails`
  
What to do:

remove the `test` folder

setup your gemfile
```
group :development, :test do
  gem 'rspec-rails'
end
```

run

`bundle install && rails generate rspec:install`

# Rubocop

Repo:
    `https://github.com/bbatsov/rubocop`
    
Setup your gemfile 

```
group :development, :test do
  gem 'rubocop', require: false
end
```

run

`rubocop --auto-gen-config`

It is going to generate a `.rubocop-todo.yml` file. Rename it to .rubocop.yml and add the following content on it
```
# This is the configuration used to check the rubocop source code.
# Check out: https://github.com/bbatsov/rubocop

AllCops:
  TargetRubyVersion: 2.3

  Include:
    - '**/config.ru'
  Exclude:
    - 'vendor/**/*'
    - 'db/**/*'
    - 'db/schema.rb'
Rails:
  Enabled: true

Style/Documentation:
  Enabled: false
  
Metrics/LineLength:
  Max: 120
```

Now run `rubocop` and start to fix the issues, it is easier if you run `rubocop -a`.

# Rubocop-Rspec

Repo:
  `https://github.com/nevir/rubocop-rspec`
  
What to do:

Add the following line in your .rubocop.yml

`require: rubocop-rspec`

setup your gemfile
```
group :development, :test do
    gem 'rubocop-rspec', :require => false
end

```

# Rubycritic

Repo:
  `https://github.com/whitesmith/rubycritic`
  
What to do:

setup your gemfile
```
group :development, :test do 
  gem 'rubycritic' 
end 
```
run

`rubycritic`


# Brakeman

Repo:
  `https://github.com/presidentbeef/brakeman`
  
What to do:


setup your gemfile
```
group :development, :test do
    gem 'brakeman', :require => false
end
```
run

`brakeman`


# BUndler audit

Repo:
  `https://github.com/rubysec/bundler-audit`

setup your gemfile
```
group :development, :test do
    gem 'bundler-audit', :require => false
end
```
run

`bundler-audit`

# Simplecov

Repo:
  `https://github.com/colszowka/simplecov`

setup your gemfile
```
group :development, :test do
    gem 'simplecov', :require => false
end
```
do

add the following content to your spec-helper

```
require 'simplecov'
SimpleCov.start
SimpleCov.minimum_coverage 90
```

# Shoulda Matchers

Repo:
    `https://github.com/thoughtbot/shoulda-matchers`
        
setup your gemfile
```
group :test do
  gem 'shoulda-matchers', '~> 3.1'
end
```

add the following content to your rails-helper, inside the RSpec config block
```
RSpec.configure do |config|
  # ...
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end
```

Now you can use matcher in your tests. For instance, a model test might look like this:
```
RSpec.describe Person, type: :model do
  it { should validate_presence_of(:name) }
end
```

# FactoryGirl

Repo:
    `https://github.com/thoughtbot/factory_girl_rails`

setup your gemfile
```
group :development, :test do
  gem 'factory_girl_rails'
end
```

Default factories directory is `test/factories`, or `spec/factories` if test_framework generator is set to `:rspec`

# Bullet

Repo:
    `https://github.com/flyerhzm/bullet`

setup your gemfile
```
group :development do
  gem 'bullet'
end
```

Configurations go into `config/environments/development.rb`.

