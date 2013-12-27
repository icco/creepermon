require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe "Site Model" do
  it 'can construct a new instance' do
    @site = Site.new
    refute_nil @site
  end
end
