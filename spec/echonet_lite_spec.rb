require "spec_helper"

RSpec.describe EchonetLite do
  it "has a version number" do
    expect(EchonetLite::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
