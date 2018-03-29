require 'spec_helper'

RSpec.describe Fortytwoish::Configuration do
  after do
    Fortytwoish.reset_configuration
  end

  it 'Uses a #configure block to configurate' do
    token = 'secret token'

    expect { set_token(token) }.to \
      change { Fortytwoish.configuration.token }.
      from(nil).to(token)
  end

  def set_token(token)
    Fortytwoish.configure do |config|
      config.token = token
    end
  end
end
