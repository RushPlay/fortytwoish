module Fortytwoish
  ALLOWED_ENCODINGS = [
    GSM7 = 'GSM7',
    UCS2 = 'UCS2',
    BINARY = 'BINARY'
  ]

  class Configuration
    attr_accessor :token
    attr_reader :encoding

    def initialize
      self.encoding = GSM7
    end

    def encoding=(new_encoding)
      return unless ALLOWED_ENCODINGS.include?(new_encoding)
      @encoding = new_encoding
    end
  end
end
