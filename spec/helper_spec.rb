require 'rails_helper'

class Test
  include Presenter::Helper
end

describe Presenter::Helper do
  let(:test)  { Test.new }
  let(:user)  { User.new first_name: 'Finn', last_name: 'Francis' }
  let(:admin) { Admin.new first_name: 'Sam', last_name: 'Sargent' }

  describe '#present' do
    context 'passing in a single model object' do
      it 'should return the relevant presenter object for the model object passed in' do
        expect(test.present(user)).to be_a UserPresenter
      end
    end

    context 'passing in a collection' do
      it 'should return an array of relevant presenter objects for each model object in the collection' do
        expect(test.present(User.all)).to all be_a(UserPresenter)
      end
    end

    context 'a presenter requiring arguments for overwridden initialize' do
      context 'passing in a single model object' do
        let(:admin_presenter)  { test.present admin, 30 }
        let(:failed_presenter) { test.present admin }

        it 'should allow a user to pass in extra arguments to send to the presenter' do
          expect { admin_presenter }.to_not raise_error
          expect(admin_presenter.subject).to eq admin
          expect(admin_presenter.age).to eq 30
        end

        context 'missing args' do
          it 'should respond with an error' do
            expect { failed_presenter }.to raise_error(Presenter::Error).with_message Presenter::Error::single_object_argument_error_message
          end
        end
      end

      context 'passing in a collection' do
        let(:admin_presenter) do
          test.present [admin] { |admin| [admin.first_name.length] }
        end

        it 'should allow a user to pass in a block to set arguments in a block' do
          expect { admin_presenter }.to_not raise_error
          expect(admin_presenter.first.age).to eql 3
        end

        context 'no block given' do
          let(:admin_presenter) { test.present [admin], *args }

          context 'argument provided' do
            let(:args) { [30] }
            it 'should not error' do
              expect { admin_presenter }.to_not raise_error
              expect(admin_presenter.first.subject).to eq admin
              expect(admin_presenter.first.age).to eq 30
            end
          end

          context 'no arguments provided' do
            let(:args) { [] }
            it 'should raise an error' do
              expect { admin_presenter }.to raise_error(Presenter::Error).with_message Presenter::Error::collection_argument_error_message
            end
          end
        end
      end
    end
  end

  context 'in a controller' do
    it 'should have access to the present method' do
      expect(ApplicationController.new).to respond_to :present
    end
  end
end
