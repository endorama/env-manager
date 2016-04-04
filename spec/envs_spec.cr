require "./spec_helper"

describe Envs do
  it "has version" do
    Envs::VERSION.should_not be_nil
  end
end
