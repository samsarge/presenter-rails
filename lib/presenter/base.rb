module Presenter
  class Base
    protected
    def method_missing(method, *args, &block)
      model_instance.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_all = false)
      model_instance.respond_to?(method, include_all)
    end

    def model_instance
      model_name = self.class.to_s.underscore.sub(/_presenter/, '')
      instance_variable_get(model_name.prepend('@'))
    end
  end
end