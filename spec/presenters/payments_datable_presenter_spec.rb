require 'rails_helper'

describe PaymentsDatatablePresenter do
  subject { described_class.new(view_context).as_json }

  let(:view_context) { view_class.new(params) }
  let(:params) { {} }
  let(:view_class) do
    Class.new do
      attr_reader :params
      def initialize(params)
        @params = HashWithIndifferentAccess.new params
      end

      def number_to_currency(number)
        "$%0.2f" % number
      end
    end
  end


  it 'returns empty set' do
    is_expected.to eq(
      draw: 0,
      recordsTotal: 0,
      recordsFiltered: 0,
      data: [],
    )
  end

  context 'when there are few students with payment' do
    let!(:jack) { create(:student, with_payments: 2, first_name: 'Jack', last_name: 'Black') }
    let!(:kyle) { create(:student, with_payments: 2, first_name: 'Kyle', last_name: 'Gas') }

    it 'return one record for each payment' do
      is_expected.to match hash_including(
        draw: 0,
        recordsTotal: Payment.count,
        recordsFiltered: Payment.count,
        data: contain_exactly(*payments_as_columns)
      )
    end

    context 'and search query is set' do
      let(:params) { { search: { value: 'black' } } }

      it 'returns only Jack\'s payments' do
        is_expected.to match hash_including(
          draw: 0,
          recordsTotal: Payment.count,
          recordsFiltered: jack.payments.count,
          data: contain_exactly(*payments_as_columns(jack.payments))
        )
      end
    end

    context 'and length is specified' do
      let(:params) { { length: 3, start: 3 } }

      it 'returns piece of data' do
        is_expected.to match hash_including(
          draw: 0,
          recordsTotal: 4,
          recordsFiltered: 4,
        )
        expect(subject[:data].length).to eq 1
      end
    end

    context 'and sorting is enabled' do
      (0..3).each do |column_no|
        context "by #{column_no}-th column (#{described_class::COLUMNS[column_no].inspect})" do
          let(:params) { { order: { '0' => { column: column_no, order: order } } } }
          let(:payments) { Payment.joins(:student).order(described_class::COLUMNS[column_no]).load }
          let(:order) { 'asc' }

          it 'returns data in order' do
            is_expected.to match hash_including(
              draw: 0,
              recordsTotal: Payment.count,
              recordsFiltered: Payment.count,
              data: contain_exactly(*payments_as_columns(payments))
            )
          end

          context 'backwards' do
            let(:order) { 'desc' }

            it 'returns data in reversed order' do
              is_expected.to match hash_including(
                draw: 0,
                recordsTotal: Payment.count,
                recordsFiltered: Payment.count,
                data: contain_exactly(*payments_as_columns(payments).reverse)
              )
            end
          end
        end
      end
    end
  end

  private

  def payments_as_columns(payments = Payment.all)
    payments.map do |payment|
      [
        payment.student.first_name,
        payment.student.last_name,
        '$%0.2f' % payment.amount,
        payment.received_at.to_s
      ]
    end
  end
end
