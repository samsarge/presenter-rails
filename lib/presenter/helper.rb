module Presenter
  module Helper
    include Presenter::Naming
    def present(model)
      presenter = presenter_from_model_object(model).new(model)
    end
  end
end
