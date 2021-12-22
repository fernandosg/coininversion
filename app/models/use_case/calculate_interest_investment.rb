module UseCase
  class CalculateInterestInvestment
    def initialize(args = {})
      @inversion = args[:inversion]
      @price_coins = args[:price_coins]
      @interest_by_coins = args[:interest_by_coins]
      @total_months = args[:total_months] || 12
    end

    def perform
      data = {
        increment_by_month: {},
        prices: {},
        total_months: @total_months
      }

      @price_coins.keys.each do |coin_symbol|
        data[:prices][coin_symbol] = @price_coins[coin_symbol].round(7)
        equivalence = get_equivalence(
          @inversion,
          @price_coins[coin_symbol]
        )
        gradual_interest = get_gradual_interest(
          @interest_by_coins[coin_symbol],
          equivalence
        )

        data[:increment_by_month][coin_symbol] ||= []
        previous_value = (equivalence + gradual_interest).round(7)

        @total_months.times do |count_month|
          data[:increment_by_month][coin_symbol] << previous_value
          previous_value = (previous_value + gradual_interest).round(7)
        end
      end

      data
    end


    private
    def get_gradual_interest(interest_by_coin, price_coin)
      return 0 if !interest_by_coin.is_a?(Numeric) || !price_coin.is_a?(Numeric)

      price_coin * interest_by_coin
    end

    def get_equivalence(initial_inversion, price_coin)
      return 0 if !initial_inversion.is_a?(Numeric) || !price_coin.is_a?(Numeric)

      ((initial_inversion * 100).to_f / price_coin).round(7)
    end
  end
end
