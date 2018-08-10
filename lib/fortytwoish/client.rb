require 'net/https'
require 'json'

module Fortytwoish
  class Client
    attr_reader :response_body

    def initialize(token:, encoding: GSM7)
      @token = token
      @encoding = encoding
    end

    def send(numbers, message)
      response = send_message(numbers, message)
      @response_body = response.body
      response.code
    end

    private

    attr_reader :token, :encoding

    def send_message(numbers, message)
      uri = URI 'https://rest.fortytwo.com/1/im'
      request = build_request(uri, numbers, message)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request request
      end
    end

    def build_request(uri, numbers, message)
      request = Net::HTTP::Post.new(uri.path)
      request['Content-Type'] = 'application/json; charset=utf-8'
      request['Authorization'] = "Token #{token}"
      request.body = body(numbers, message)
      request
    end

    def body(numbers, message)
      {
        destinations: numbers.map { |number| { number: number } },
        sms_content: {
          message: message,
          encoding: encoding
        }
      }.to_json
    end
  end
end
