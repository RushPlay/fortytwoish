require 'spec_helper'

RSpec.describe Fortytwoish::Client do
  let(:message) { 'hello, world' }
  let(:number) { '46703051158' }
  subject { Fortytwoish::Client.new(number, message).send }

  context 'for successful sends' do
    it 'returns true' do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"46703051158"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token ', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 200)

      is_expected.to eq true
    end
  end

  context 'when the server complains' do
    it 'throws an error' do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"46703051158"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token ', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 400)

      expect { subject }.to raise_error(Fortytwoish::FortytwoRuntimeError)
    end
  end

end
