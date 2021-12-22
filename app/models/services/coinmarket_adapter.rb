module Services
  class CoinmarketAdapter < Services::BaseService
    CONFIGURACION = {
      urls: {
        latest: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?&symbol=%{coins}"
      },
      API_KEY: ''
    }

    def initialize(args = {})
      super(args)

      @configuracion = CONFIGURACION.merge(args)
    end

    def get_coins_prices(coins = [])
      if coins.blank? || !coins.is_a?(Array)
        set_result({
          code: 500,
          message: 'Se debe definir al menos una moneda',
          success: false
        })

        return {}
      end

      get_latest({ coins: coins.join(',') })
    end

    private
    def get_latest(payload = {})
      headers_request = headers

      if payload && payload[:headers]
        headers_request.merge!(payload[:headers])
      end

      begin
        response = execute({
          url: (latest_coins_url % { coins: payload[:coins] }),
          header: headers_request
        })

        set_result(
          response: JSON.parse(response),
          success: true
        )
      rescue RestClient::BadRequest => e
        set_result(
          response: '',
          success: false,
          message: e.message,
          code: 400
        )
      end

      get_response
    end

    def latest_coins_url
      @configuracion[:urls][:latest]
    end


    def configuracion
      @configuracion
    end

    def headers
      @headers ||= {
        'X-CMC_PRO_API_KEY' => @configuracion[:API_KEY],
        'Accept' => 'application/json'
      }
    end
  end
end
