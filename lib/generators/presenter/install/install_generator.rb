module Presenter
  module Generators
    class InstallGenerator < Rails::Generators::Base
      APPLICATION_RB = Rails.root.join('config/application.rb')

      source_root File.expand_path('../templates', __FILE__)
      class_option :doc, type: :boolean, default: true, desc: 'Include commented documentation'
      class_option :require, type: :boolean, default: true, desc: 'Require presenter,
        and autoload the presenter directory'

      def generate_application_presenter
        template 'application_presenter.template', 'app/presenters/application_presenter.rb'
      end

      def require_and_load_presenter
        return false unless options[:require]
        inject_into_autoload_path
        inject_require_into_application_rb
      end

      private

      def inject_into_autoload_path
        insert_into_file APPLICATION_RB,
                         "\t\tconfig.autoload_paths << Rails.root.join('app/presenters')\n\n",
                         after: "class Application < Rails::Application\n"
      end

      def inject_require_into_application_rb
        insert_into_file APPLICATION_RB,
                         "require 'presenter'\n\n",
                         before: /module .*\n\s+class Application \< Rails::Application/
      end
    end
  end
end
