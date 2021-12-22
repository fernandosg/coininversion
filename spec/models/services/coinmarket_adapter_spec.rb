require 'rails_helper'

RSpec.describe 'Services::CoinmarketAdapter', type: :model do
  subject(:adapter) { Services::CoinmarketAdapter.new(arguments) }
  let(:arguments) do
    { API_KEY: ENV['COINMARKET_KEY'] }
  end

  describe '#get_coins_prices' do
    context 'when there is coins passed to method' do
      context 'and the coins exist in services' do
        let(:coins) { ['BTC'] }

        it 'return the structure of information for the coin' do
          information = adapter.get_coins_prices(coins)

          expect(information['status']['error_message']).to be_nil
          expect(information['data'].keys).to include(*coins)
          expect(adapter.get_code).to be_eql(200)
        end
      end

      context 'and the coins doesnt exist in the services' do
        it 'return an structure with error 400' do
          information = adapter.get_coins_prices(['DDDQW'])

          expect(adapter.success?).to be_falsy
          expect(information).to be_empty
          expect(adapter.get_code).to be_eql(400)
        end
      end
    end

    context 'when the coins are not passed' do
      let(:coins) { [] }

      it 'return the structure of information for the coin' do
        information = adapter.get_coins_prices(coins)

        expect(information).to be_empty
        expect(adapter.success?).to be_falsy
        expect(adapter.get_code).to be_eql(500)
      end
    end
  end
end
