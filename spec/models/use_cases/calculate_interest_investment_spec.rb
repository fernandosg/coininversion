require 'rails_helper'

RSpec.describe 'UseCase::CalculateInterestInvestment', type: :model do
  subject(:use_case) { UseCase::CalculateInterestInvestment.new(arguments) }
  let(:arguments) do
    {
      inversion: 500,
      price_coins: { BTC: 59000 },
      interest_by_coins: { BTC: 0.05 },
      total_months: 3
    }
  end

  let(:increment_by_month) do
    {
      BTC: [0.8898305, 0.9322034, 0.9745763]
    }
  end

  context '#perform' do
    context 'when the inversion is 500 usd for a BTC with value 5900' do
      context 'and an interest of 5%' do
        it 'returns the correct relation of interes by month' do
          data = use_case.perform

          expect(data[:increment_by_month][:BTC]).to be_eql(
            increment_by_month[:BTC]
          )
        end
      end
    end
  end
end
