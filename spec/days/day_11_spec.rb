require "spec_helper"
require_relative "../../src/days/day_11"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    INPUT
  }

  let(:small_input) {
    <<~INPUT.chomp
      11111
      19991
      19191
      19991
      11111
    INPUT
  }

  it "does a smaller simualtion right" do
    expect(subject.call(small_input, 2)).to eq "9, 4"
  end

  it "calculates the score for both" do
    expect(subject.call(input, 100)).to eq "1656, 195"
  end
end
