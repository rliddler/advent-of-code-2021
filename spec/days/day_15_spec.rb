require "spec_helper"
require_relative "../../src/days/day_15"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
    INPUT
  }

  it "finds the path left to right with least risk" do
    expect(subject.a(input)).to eq 40
  end
end
