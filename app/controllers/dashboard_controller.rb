require 'csv'
class DashboardController < ApplicationController
  before_action :set_coins, only: :calculate

  def index
  end

  def calculate
    service = Services::CoinmarketAdapter.new(
      API_KEY: ENV['COINMARKET_KEY']
    )
    @data = {}
    service.get_coins_prices(@coins)

    if service.success?
      use_case = UseCase::CalculateInterestInvestment.new(
        inversion: params['inversion'].try(:to_f),
        price_coins: extract_information_from_api(service.get_response),
        interest_by_coins: { 'BTC' => 0.05, 'ETH' => 0.03 }
      )

      @data = use_case.perform
    end

    respond_to do |format|
      format.js
      format.csv do
        response.headers['Content-Disposition'] = 'attachment; filename=data_coins.csv'
      end

      format.json do
        send_data @data[:increment_by_month].to_json, :type => 'application/json; header=present', :disposition => "attachment; filename=data_coins.json"
      end
    end
  end

  private
  def extract_information_from_api(response_api)
    information_price = {}

    response_api['data'].keys.each do |coin|
      information_price[coin] = response_api['data'][coin]['quote']['USD']['price']
    end

    information_price
  end

  def set_coins
    @coins = ['BTC', 'ETH']
  end
end
