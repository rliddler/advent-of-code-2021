require "spec_helper"
require_relative "../../src/days/day_13"

describe Day do
  let(:input) {
    <<~INPUT.chomp
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5
    INPUT
  }

  it "does a smaller simualtion right" do
    expect(subject.call(input)).to eq "17, "
  end
end
