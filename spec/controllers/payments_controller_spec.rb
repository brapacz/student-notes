require 'rails_helper'

RSpec.describe PaymentsController do
  let(:user) { create :user }

  before { sign_in user }

  describe 'GET #index' do
    subject { get :index }
    it_behaves_like 'template rendering action', :index

    describe 'format: json' do
      before { expect(PaymentsDatatablePresenter).to receive(:new).and_return(presenter) }
      subject { get :index, format: 'json' }

      let(:presenter) { double(:presenter) }
      it { expect(subject.body).to eq presenter.to_json }
    end
  end
end
