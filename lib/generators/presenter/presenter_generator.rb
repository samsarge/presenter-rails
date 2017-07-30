module Presenter
  class PresenterGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    class_option :doc, type: :boolean, default: true, desc: 'Include commented documentation'
    argument :model, type: :string

    def generate_model_presenter
      template 'model_presenter.template', "app/presenters/#{model.singularize.underscore}_presenter.rb"
    end
  end
end
