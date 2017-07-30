# This module is for naming related methods
module Presenter
  module Naming
    def model_object_name_from_presenter(model)
      model.class.to_s.underscore.sub('_presenter', '')
    end

    def presenter_from_model_object(model)
      presenter_name(model).constantize
    end

    private
    def presenter_name(model)
      "#{model.class.to_s}Presenter"
    end
  end
end
