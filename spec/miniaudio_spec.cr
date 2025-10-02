require "./spec_helper"

describe Miniaudio do
  it "has a version number" do
    Miniaudio::VERSION.should be_a(String)
  end

  it "can get version info" do
    m, i, p = Miniaudio.version
    Miniaudio.version_string.should eq("#{m}.#{i}.#{p}")
  end
end
