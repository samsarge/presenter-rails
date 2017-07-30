require 'rails_helper'

class Test
  include Presenter::Helper
end

describe Presenter::Helper do
  let(:test) { Test.new }
  let(:user) { User.new first_name: 'Finn', last_name: 'Francis' }

  describe '#present' do
    it 'should return the relevant presenter object for the model object passed in' do
      expect(test.present(user)).to be_a UserPresenter
    end
  end

  context 'in a controller' do
    it 'should have access to the present method' do
      expect(ApplicationController.new).to respond_to :present
    end
  end
end
