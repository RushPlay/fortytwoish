require 'spec_helper'

RSpec.describe Fortytwoish::Client do
  let(:message) { 'hello, world' }
  let(:number) { '15415553010' }
  subject { Fortytwoish::Client.new(number, message).send }

  around do |example|
    Fortytwoish.configure do |config|
      config.token = 'TESTTOKEN'
      config.encoding = Fortytwoish::UCS2
    end

    example.run

    Fortytwoish.reset_configuration
  end

  context 'for successful sends' do
    before do
      message_body = <<~JSON.strip
        {"destinations":[{"number":"15415553010"}],"sms_content":{"message":"hello, world","encoding":"UCS2"}}
      JSON
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(
          body: message_body,
          headers: {
            'Authorization': 'Token TESTTOKEN',
            'Content-Type': 'application/json; charset=utf-8'
          }
        ).to_return(status: 200)
    end

    it { is_expected.to eq '200' }
  end

  context 'when the server complains' do
    before do
      message_body = <<~JSON.strip
        {"destinations":[{"number":"15415553010"}],"sms_content":{"message":"hello, world","encoding":"UCS2"}}
      JSON
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(
          body: message_body,
          headers: {
            'Authorization': 'Token TESTTOKEN',
            'Content-Type': 'application/json; charset=utf-8'
          }
        ).to_return(status: 400)
    end

    it { is_expected.to eq '400' }
  end

  context 'with several numbers' do
    let(:number) { ['15415553010', '15415553011'] }

    before do
      message_body = <<~JSON.strip
        {"destinations":[{"number":"15415553010"},{"number":"15415553011"}],"sms_content":{"message":"hello, world","encoding":"UCS2"}}
      JSON
      stub_request(:post, 'https://rest.fortytwo.com/1/im').
        with(
          body: message_body,
          headers: {
            'Authorization': 'Token TESTTOKEN',
            'Content-Type': 'application/json; charset=utf-8'
          }
        ).to_return(status: 200)
    end

    it { is_expected.to eq '200' }
  end
end
