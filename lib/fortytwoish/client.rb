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

      raise FortytwoRuntimeError, "Fortytwo error: #{response.message}" unless response.code == '200'
      true
    end

    private

    attr_reader :message, :number

    def configuration
      @configuration ||= Fortytwoish.configuration
    end

    def send_message
      uri = URI 'https://rest.fortytwo.com/1/im'
      request = Net::HTTP::Post.new(uri.path)
      request['Content-Type'] = 'application/json; charset=utf-8'
      request['Authorization'] = "Token #{configuration.token}"
      request.body = body
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request request
      end
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
