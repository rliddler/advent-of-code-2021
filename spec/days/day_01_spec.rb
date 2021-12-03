require "spec_helper"
require_relative "../../src/days/day_01"

describe Day do
  let(:input) {
    <<~INPUT.chomp
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
    INPUT
  }

  it "calculates the number of increases in depth" do
    expect(subject.a(input)).to eq 7
  end

  it "calculates the average 3 sliding window increases in depth" do
    expect(subject.b(input)).to eq 5
  end
end
