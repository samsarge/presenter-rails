require 'rails_helper'

# Use this spec to test the application of rails presenter
describe UserPresenter do
  let(:user) { User.create(first_name: "Sam", last_name: "Sargent")}
  let(:presenter) { TestUserPresenter.new(user, 'Finn') }

  describe 'overriding the initialize' do
    it 'should allow the initialize to be overridden' do
      expect { presenter }.to change { user.reload.first_name }.to 'Finn'
      expect(presenter).to respond_to :user
    end

    it 'should keep all of the Presenter::Base functionality' do      
      expect(presenter).to respond_to :last_name
      expect(presenter).to respond_to :subject
    end
  end
end

class TestUserPresenter < ApplicationPresenter
  attr_reader :user

  def initialize(user, first_name)
    @user = user
    @user.update first_name: first_name
    super user
  end
end
