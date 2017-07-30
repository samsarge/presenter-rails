require 'rails_helper'
describe Presenter::Base do
  context 'all presenter models' do
    let(:user) { User.new(first_name: "Sam", last_name: "Sargent")}
    let(:presenter) { UserPresenter.new(user) }

    describe '#method_missing' do
      it 'should call the method from the model passed in if it does not exist in the presenter' do
        expect(presenter.class.ancestors).to include Presenter::Base
        expect(presenter.first_name).to eq user.first_name
        expect(presenter.last_name).to eq user.last_name
      end
    end

    describe '#respond_to?' do
      it 'should delegate #respond_to? to the instance variable of the model if the presenter does not respond to it' do
        expect(presenter).to respond_to(:id)
      end
    end

    describe '#generate_model_instance_getter' do
      it 'should create a getter method for the model instance with the same name as the model you pass in' do
        expect(presenter).to respond_to :user
        expect(presenter.user).to eq user
      end
    end
  end
end
