class AdminPresenter < ApplicationPresenter
  attr_reader :subject, :age

  def initialize(admin, age)
    @subject = admin
    @age     = age
  end
end
