require "spec_helper"
require_relative "../../src/days/day_05"

describe Day do
  let(:input) {
    <<~INPUT.chomp
      0,9 -> 5,9
      8,0 -> 0,8
      9,4 -> 3,4
      2,2 -> 2,1
      7,0 -> 7,4
      6,4 -> 2,0
      0,9 -> 2,9
      3,4 -> 1,4
      0,0 -> 8,8
      5,5 -> 8,2
    INPUT
  }

  let(:parsed_lines) do
    [
      Line.new(0,9,5,9),
      Line.new(8,0,0,8),
      Line.new(9,4,3,4),
      Line.new(2,2,2,1),
      Line.new(7,0,7,4),
      Line.new(6,4,2,0),
      Line.new(0,9,2,9),
      Line.new(3,4,1,4),
      Line.new(0,0,8,8),
      Line.new(5,5,8,2),
    ]
  end

  describe "parsing this mess" do
    it "returns an array of points" do
      result = subject.parse(input)
      expect(result).to eq parsed_lines
    end
  end

  it "calculates the crossing horizontal and vertical lines" do
    expect(subject.a(parsed_lines,10,10)).to eq 5
  end

  it "calculates the diagonal crossing lines" do
    expect(subject.b(parsed_lines,10,10)).to eq 12
  end
end





