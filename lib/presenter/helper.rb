module Presenter
  module Helper
    include Presenter::Naming
    def present(object_or_collection, *args, &block)
      if object_or_collection.respond_to?(:map)
        handle_collection(object_or_collection, *args, &block)
      else
        handle_single_object(object_or_collection, *args)
      end
    end

    def handle_single_object(object, *args)
      presenter_from_model_object(object).new(object, *args)
    rescue ArgumentError
      raise Presenter::Error, Presenter::Error::single_object_argument_error_message
    end

    def handle_collection(collection, *args, &block)
      collection.map do |object|
        block_args = block_given? ? block.call(object) : []
        presenter_from_model_object(object).new(object, *args, *block_args)
      end
    rescue ArgumentError
      raise Presenter::Error, Presenter::Error::collection_argument_error_message
    end
  end
end
