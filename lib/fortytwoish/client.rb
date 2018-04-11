require 'net/https'
require 'json'

module Fortytwoish
  class Client
    def initialize(number, message)
      @message = message
      @number = number
    end

    def send
      response = send_message
      response.code
    end

    private

    attr_reader :message, :number

    def configuration
      @configuration ||= Fortytwoish.configuration
    end

    def send_message
      uri = URI 'https://rest.fortytwo.com/1/im'
      request = build_request(uri)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request request
      end
    end

    def build_request(uri)
      request = Net::HTTP::Post.new(uri.path)
      request['Content-Type'] = 'application/json; charset=utf-8'
      request['Authorization'] = "Token #{configuration.token}"
      request.body = body
      request
    end

    def body
      {
        destinations: [
          number: number
        ],
        'sms_content': { message: message }
      }.to_json
    end
  end
end
