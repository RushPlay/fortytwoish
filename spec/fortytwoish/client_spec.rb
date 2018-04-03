require 'spec_helper'

RSpec.describe Fortytwoish::Client do
  let(:message) { 'hello, world' }
  let(:number) { '15415553010' }
  subject { Fortytwoish::Client.new(number, message).perform }

  context 'for successful sends' do
    before do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"15415553010"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token ', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 200)
    end

    it { is_expected.to eq '200' }
  end

  context 'when the server complains' do
    before do
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(body: '{"destinations":[{"number":"15415553010"}],"sms_content":{"message":"hello, world"}}',
             headers: { 'Authorization': 'Token ', 'Content-Type': 'application/json; charset=utf-8' }).
        to_return(status: 400)

    end

    it { is_expected.to eq '400' }
  end

end
