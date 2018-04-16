require 'spec_helper'

RSpec.describe Fortytwoish::Client do
  let(:message) { 'hello, world' }
  let(:number) { '46703051158' }
  subject { Fortytwoish::Client.new(number, message).send }

  before do
    Fortytwoish.configure do |config|
      config.token = 'TESTTOKEN'
    end
  end

  after do
    Fortytwoish.reset_configuration
  end

  context 'for successful sends' do
    before do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"46703051158"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token TESTTOKEN', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 200)
    end

    it { is_expected.to eq '200' }
  end

  context 'when the server complains' do
    before do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"46703051158"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token TESTTOKEN', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 400)
    end

    it { is_expected.to eq '400' }
  end

  context 'with several numbers' do
    let(:number) { ['46703051158', '461234567'] }

    before do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"46703051158"},{"number":"461234567"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token TESTTOKEN', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 200)
    end

    it { is_expected.to eq '200' }
  end
end
