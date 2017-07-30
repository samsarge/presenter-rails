module Presenter
  class Base
    def initialize(model)
      @model = model
      generate_model_instance_getter
    end

    protected
    def generate_model_instance_getter
      define_singleton_method model_name do
        @model
      end
    end

    def method_missing(method, *args, &block)
      @model.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_all = false)
      @model.respond_to?(method, include_all)
    end

    def model_name
      self.class.to_s.underscore.sub('_presenter', '')
    end
  end
end
