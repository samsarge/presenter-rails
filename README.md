# presenter-rails

  Presenter is an easy way of implementing the presenter design pattern in Rails.

  With a naming convention based approach, easily define presenter classes to clean up
  your models and views, handling method delegation based on instance variable & file naming.

  This should hopefully mean you can just use presenter objects in place of model objects
  throughout your app without effecting any behaviour - as you can still call your custom model
  methods and active record methods on the presenter objects.

  This ultimately means all methods that belong to the model stay on the model itself
  and seperated from any methods which don't handle data.

  All presenter classes inherit from ApplicationPresenter generated from the install to keep the same
  convention you see throughout the rest of your Rails app.

## Installation
Add this line to your application's Gemfile and bundle:
```ruby
gem 'presenter-rails'
```
```bash
$ bundle
```
Run the install generator
```bash
$ rails g presenter:install
```
Add this line to the top of your application.rb
```ruby
# config/application.rb
require 'presenter'
```
Followed by this line inside the Application class
```ruby
# config/application.rb
module YourAppName
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('app/presenters')
  end
end
```

## Usage

These instructions will use a 'User' model for example purposes. Just switch out User for your own model names

After you run the install generator, run
```bash
$ rails g presenter User
```

to create a presenter file for one of your models. This will inherit from ApplicationPresenter, example shown below:
```ruby
# app/presenters/user_presenter.rb
class UserPresenter < ApplicationPresenter
end
```

Note: This provides you with a getter method: #subject.
You can use #subject to acces the model you passed in e.g.
```ruby
# app/presenters/user_presenter
def full_name
  subject.first_name + ' ' + subject.last_name
end
```

If you do wish to extend the initialize method, call super as demonstrated below:
```ruby
def initialize(user, middle_name)
  @user = user
  @user.update middle_name: middle_name
  super user
end
```
Make sure to pass your model to super.

Now you can initialize a presenter. There are 2 methods for this, either directly initialize the object as usual with:
```ruby
@user = UserPresenter.new(user)
```
or use our built in helper to accomplish the same thing:
```ruby
# The present helper will work with a single model or a collection
@user = present(user)
@users = present(User.all)
```
(More on this below)

Example provided shows how it would be used in a controller:
```ruby
class UsersController < ApplicationController
  def show
    user = User.find(params[:id]) # get an instance of user
    @user = present(user)
  end
end
```

Now the user instance variable has access to all methods belonging to it's presenter and the model being passed in.
This allows access to:
```ruby
@user.name
# which returns first name and last name like 'Sam Sargent'
# or even call the normal model methods
@user.first_name
# which would delegate the method back to the user model being passed into the present helper
# returning something like 'Sam'
# Note: This works with all ActiveRecord methods too, just as if it's an object of the ActiveRecord class User
#       allowing access to even @user.update(first_name: 'Finn') on the presenter object
```

## Helper methods

### #present

  #present is a method accessible in controllers and views for initializing new presenter objects
```ruby
  user = User.first
  @user = present(user) # returns a presenter object for that model, replacing need to initialize with #new

  # instead of
  user = User.first
  @user = UserPresenter.new(user)

  # alternatively, pass in a collection to return an array of presenter objects
  users = User.all        # an active record relation
  @users = present(users)
  users = User.all.to_a   # an array
  @users = present(users)
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
