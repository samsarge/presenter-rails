module Presenter
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      class_option :doc, type: :boolean, default: true, desc: 'Include commented documentation'

      def generate_application_presenter
        template 'application_presenter.template', 'app/presenters/application_presenter.rb'
      end
    end
  end
end