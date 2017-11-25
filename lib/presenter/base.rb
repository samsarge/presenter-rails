module Presenter
  class Base
    include Presenter::Naming

    attr_reader :subject

    def initialize(subject)
      @subject = subject
    end

    protected

    def method_missing(method, *args, &block)
      subject.send(method, *args, &block)
    end

    def respond_to_missing?(method, include_all = false)
      subject.respond_to?(method, include_all)
    end
  end
end
