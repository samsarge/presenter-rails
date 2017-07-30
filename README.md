# presenter-rails

  Presenter is an easy way of implementing the presenter design pattern in Rails.

  With a naming convention based approach, easily define presenter classes to clean up
  your models and views, handling method delegation based on instance variable & file naming.

  This should hopefully mean you can just use instances of a presenter in place of model instances
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
app/presenters/user_presenter.rb
class UserPresenter < ApplicationPresenter
end
```

This automatically inherits a dynamic initialize method which sets an instance variable named after your model as shown below:
```ruby
def initialize
  @user = user
end
```
along with some error handling and some other code. You don't have to worry about this. Just remember you don't need to define
an initialize method and if you do, remember to super or you will overwrite the default behaviour.

This means you can define methods in your presenter using the instance variable named after your model.
Let's imagine our User model has a first_name and last_name field and we want to define #name. All we would have to do is:
```ruby
class UserPresenter < ApplicationPresenter
  def name
    "#{@user.first_name} #{@user.last_name}"
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
# Note: This works all ActiveRecord methods too, just as if it's an object of the ActiveRecord class User
# allowing access to even @user.update(first_name: 'Finn')
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
