require "spec_helper"
require_relative "../../src/days/day_06"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    3,4,3,1,2
    INPUT
  }

  it "calculates the growth of lantern fish" do
    expect(subject.a(input, 80)).to eq 5934
  end
end
