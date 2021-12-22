module Services
  class BaseService
    def initialize(args = {})
      @result = {
        success: true,
        response: {},
        message: '',
        code: 200
      }
    end


    def set_result(args = {})
      @result.merge!(args)
    end

    def success?
      @result[:success]
    end

    def get_response
      @result[:response] || {}
    end

    def get_code
      @result[:code]
    end

    def execute(args = {})
      RestClient::Request.execute(
        method: (:get || args[:method]),
        url: args[:url],
        payload: (args[:payload] || {}),
        headers: (args[:header] || {}),
        params: (args[:params] || {})
      )
    end
  end
end
