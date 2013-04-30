require 'spec_helper'

describe "Site Model" do
  let(:site) { Site.new }
  it 'can be created' do
    site.should_not be_nil
  end
end
