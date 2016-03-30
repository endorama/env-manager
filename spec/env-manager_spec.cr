require "./spec_helper"

describe Env::Manager do
  it "has version" do
    Env::Manager::VERSION.should_not be_nil
  end
end
