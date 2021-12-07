require "spec_helper"
require_relative "../../src/days/day_07"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    16,1,2,0,4,2,7,1,2,14
    INPUT
  }

  it "calculates the optimum position for fuel cost, and that cost" do
    expect(subject.call(input)).to eq "37, 168"
  end
end
