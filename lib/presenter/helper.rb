module Presenter
  module Helper
    include Presenter::Naming
    def present(object_or_collection)
      if object_or_collection.respond_to?(:map) # If it is a collection
        object_or_collection.map { |object| presenter_from_model_object(object).new(object) }
      else # If it is a single object
        presenter_from_model_object(object_or_collection).new(object_or_collection)
      end
    end
  end
end
