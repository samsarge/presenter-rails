class ApplicationPresenter < Presenter::Base
    # Presenter::Base handles delegation of methods based on instance variable & file naming.
    # Use rails g presenter ModelName to create a presenter file for the model.
    # Keep naming of instance variables the same as the model name and you should
    # be able to just use the presenter and continue using methods on the model
    # even if they aren't defined in the presenter class.

    # This should hopefully mean you can just use instances of a presenter in place of
    # model instances throughout your app without effecting any behaviour,
    # ultimately meaning all methods that belong to the model stay on the model itself
    # and seperated from any methods which don't handle data.

    # All presenter classes inherit from this ApplicationPresenter and so define
    # methods here which you want all your presenters to inherit (just as you usually would).
end