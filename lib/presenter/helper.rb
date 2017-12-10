module Presenter
  module Helper
    include Presenter::Naming
      if object_or_collection.respond_to?(:map) # If it is a collection
        object_or_collection.map { |object| presenter_from_model_object(object).new(object) }
    def present(object_or_collection, *args, &block)
      else
        handle_single_object(object_or_collection, *args)
      end
    end

    def handle_single_object(object, *args)
      presenter_from_model_object(object).new(object, *args)
    rescue ArgumentError
      raise Presenter::Error, Presenter::Error::single_object_argument_error_message
    end
  end
end
