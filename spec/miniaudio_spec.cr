require "./spec_helper"

describe Miniaudio do
  it "has a version number" do
    Miniaudio::VERSION.should be_a(String)
  end
end
