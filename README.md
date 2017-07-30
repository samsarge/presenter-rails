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
Add this line to your application's Gemfile:

```ruby
gem 'presenter-rails'
```

And then execute:
```bash
$ bundle
```

Add this line to the top of your application.rb
```ruby
require 'presenter'
```

Followed by this line inside class Application < Rails::Application
```ruby
config.autoload_paths << Rails.root.join('app/presenters')
```

Finally, run
```bash
$ rails g presenter:install
```
to create the folder along with the ApplicationPresenter file

## Usage

These instructions will user a 'User' model for example purposes. Just switch out User for your own model names

After you run the install generator
Use
```bash
$ rails g presenter User
```

to create a presenter file for one of your models. This will inherit from ApplicationPresenter, example shown below:
```ruby
# app/presenters/user_presenter.rb
class UserPresenter < ApplicationPresenter
end
```

Note: This automatically inherits a dynamic initialize method which sets an instance variable. You also inherit a helper method dynamically named after the model too.
So you DO NOT have to define this yourself:
```ruby
def initialize(user)
  @user = user
end

def user # Make sure you use the helper methods in your presenters in place of the instance variable.
  @user
end
```

This also comes with with some error handling and some other code. So don't worry about this.
I'm showing it just so you know what to expect if you try overwrite initialize or the helper without super. If you wish to extend it
then remember to super or you will overwrite the default behaviour.

If you do wish to extend the initialize method / change the instance variable name, call super first. Next, define an instance variable and assign it to the model object using the helper method (named after the model name).
```ruby
def initialize(user)
  super
  # assigning your variable to the user method gives it access to the inherited code.
  @another_variable_name = self.user
end
```

This means you can define methods in your presenter using the instance variable named after your model.
Let's imagine our User model has a first_name and last_name field and we want to define #name. All we would have to do is:
```ruby
class UserPresenter < ApplicationPresenter
  def name
    "#{user.first_name} #{user.last_name}"
  end
end
```

now you can initialize a presenter. There is 2 methods to this, either directly initialize the object as usual with:
```ruby
@user = UserPresenter.new(user)
```
or use our built in helper to accomplish the same thing:
```ruby
@user = present(user)
```

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
This allows access to
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

### #model

For each presenter you create, a helper method is defined to get the model object being passed in. This replaces the need to throw around
the instance variable. It's also faster as it allows the method delegation to not have to parse naming and fetch instance variables every time the inherited #method_missing is called.

shown using a User model as example
```ruby
# app/presenters/user_presenter.rb
class UserPresenter < ApplicationPresenter
  # this has the method #user defined automatically to access the user object being passed in to the presenter
  def name
    "#{user.first_name} {user.last_name}"
  end
end
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
