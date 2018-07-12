require 'spec_helper'

RSpec.describe Fortytwoish::Configuration do
  after do
    Fortytwoish.reset_configuration
  end

  describe 'by default' do
    it 'sets initial value for token' do
      expect(Fortytwoish.configuration.token).to be_nil
    end

    it 'sets initial value for encoding' do
      expect(Fortytwoish.configuration.encoding).to eq(Fortytwoish::GSM7)
    end
  end

  describe 'token configuration' do
    it 'changes token' do
      token = 'secret token'

      expect { set_token(token) }.to \
        change { Fortytwoish.configuration.token }.
        from(nil).to(token)
    end
  end

  describe 'encoding configuration' do
    context 'with valid encoding' do
      it 'changes encoding' do
        new_encoding = 'UCS2'

        expect { set_encoding(new_encoding) }.to \
          change { Fortytwoish.configuration.encoding }.
          from('GSM7').to(new_encoding)
      end
    end

    context 'with invalid encoding' do
      it 'does not change encoding' do
        new_encoding = 'UCS44'

        expect { set_encoding(new_encoding) }.not_to \
          change { Fortytwoish.configuration.encoding }
      end
    end
  end

  def set_encoding(encoding)
    Fortytwoish.configure do |config|
      config.encoding = encoding
    end
  end

  def set_token(token)
    Fortytwoish.configure do |config|
      config.token = token
    end
  end
end
