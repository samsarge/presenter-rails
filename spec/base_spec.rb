require 'rails_helper'
describe Presenter::Base do
  context 'all presenter models' do
    User ||= Struct.new(:id, :first_name, :last_name)
    let(:user) { User.new(1, "Sam", "Sargent")}
    let(:presenter) { UserPresenter.new(user) }

    describe '#method_missing' do
      it 'should call the method from the model passed in if it does not exist in the presenter' do
        expect(presenter.class.ancestors).to include Presenter::Base
        expect(presenter.first_name).to eq user.first_name
      end
    end

    describe '#respond_to?' do
      it 'should delegate #respond_to? to the instance variable of the model if the presenter does not respond to it' do
        expect(presenter).to respond_to(:id)
        # Normally the presenter would not RESPOND TO id, as technically id is
        # not a method on the presenter (due to it getting delegated to the instance variable)
      end
    end
  end
end
