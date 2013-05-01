require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Ping Model" do
  it 'can construct a new instance' do
    @ping = Ping.new
    refute_nil @ping
  end
end
