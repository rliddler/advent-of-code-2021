require "spec_helper"
require_relative "../../src/days/day_09"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
    INPUT
  }

  it "calculates the thing with the display etc" do
    expect(subject.call(input)).to eq "15, 1134"
  end
end
