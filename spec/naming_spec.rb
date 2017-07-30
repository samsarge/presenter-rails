require 'rails_helper'

class Test
  include Presenter::Naming
end

describe Presenter::Naming do
  let(:user) { User.new first_name: 'Finn', last_name: 'Francis' }
  let(:user_presenter) { UserPresenter.new(user) }
  let(:test) { Test.new }

  describe '#model_object_name_from_presenter' do
    it 'should return the model name' do
      expect(test.model_object_name_from_presenter(user_presenter)).to eq 'user'
    end
  end

  describe '#presenter_from_model_object' do
    it 'should return the relevant presenter class for the model' do
      expect(test.presenter_from_model_object(user)).to be UserPresenter
    end
  end

  context 'private methods' do
    describe '#presenter_name' do
      it 'should return the relevant presenter name as a string' do
        expect(test.send(:presenter_name, user)).to eq 'UserPresenter'
      end
    end
  end
end
