require 'spec_helper'

RSpec.describe Fortytwoish::Client do
  let(:message) { 'hello, world' }
  let(:number) { '15415553010' }
  subject(:client) { described_class.new(token: 'TESTTOKEN', encoding: Fortytwoish::UCS2) }

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
        ).to_return(status: 200, body: 'OK')
    end

    it { expect(client.send([number], message)).to eq '200' }
    it 'assigns correct response_body' do
      client.send(number, message)
      expect(client.response_body).to eq('OK')
    end
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
        ).to_return(status: 400, body: 'ERR')
    end

    it { expect(client.send(number, message)).to eq '400' }
    it 'assigns correct response_body' do
      client.send([number], message)
      expect(client.response_body).to eq('ERR')
    end
  end

  context 'with several numbers' do
    let(:numbers) { ['15415553010', '15415553011'] }

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
        ).to_return(status: 200, body: 'OK')
    end

    it { expect(client.send(numbers, message)).to eq '200' }
    it 'assigns correct response_body' do
      client.send(numbers, message)
      expect(client.response_body).to eq('OK')
    end
  end
end
