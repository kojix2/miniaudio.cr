require "./spec_helper"

describe Miniaudio do
  it "has a version number" do
    Miniaudio::VERSION.should be_a(String)
  end

  it "exposes the native version numbers" do
    Miniaudio.version.should eq({0_u32, 11_u32, 21_u32})
  end

  it "exposes the native version string" do
    Miniaudio.version_string.should eq("0.11.21")
  end
end
