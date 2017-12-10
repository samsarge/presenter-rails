module Presenter
  class Error < StandardError
    class << self
      def single_object_argument_error_message
        example = <<-EXAMPLE
          You have overridden the initialize method in your presenter to take in extra arguments.
          Pass in extra arguments to the #present method e.g.
          present(@user, 'my_first_name', 'my_last_name')
        EXAMPLE

        "Wrong number of arguments\n#{example}"
      end

      def collection_argument_error_message
        example = <<-EXAMPLE
          When passing arguments to #present in a collection you can use a block e.g.
          present(@user) { |user| [user.first_name, user.last_name] }
          For more detailed examples, go to https://github.com/samsarge/presenter-rails/wiki/%23present-method
        EXAMPLE
        "Wrong number of arguments\n#{example}"
      end
    end
  end
end
