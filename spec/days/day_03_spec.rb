require "spec_helper"
require_relative "../../src/days/day_03"

describe Day do
  let(:input) {
    <<~INPUT.chomp
      00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010
    INPUT
  }

  it "calculates the bit thing" do
    expect(subject.a(input)).to eq 198
  end

  it "calculates the CO2 and oxygen" do
    expect(subject.b(input)).to eq 230
  end
end
