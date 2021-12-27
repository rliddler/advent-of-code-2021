require "spec_helper"
require_relative "../../src/days/day_25"

describe Day do
  let(:small_input) {
    <<~INPUT.chomp
    ...>...
    .......
    ......>
    v.....>
    ......>
    .......
    ..vvv..
    INPUT
  }

  let(:medium_input) {
    <<~INPUT.chomp
v...>>.vv>
.vv>>.vv..
>>.>v>...v
>>v>>.>.v.
v>v.vv.v..
>.>>..v...
.vv..>.>v.
v.v..>>v.v
....v..v.>
    INPUT
  }

  it "does the line of them right" do
    input = "...>>>>>..."
    expected = "...>>>.>.>."

    expect(subject.simulate(input, 2)[0]).to eq expected
  end

  it "returns the number of iterations when no one moved" do
    expect(subject.a(medium_input)).to eq 58
  end

  it "does a smaller simulation right" do
    expected = <<~INPUT.chomp
      >......
      ..v....
      ..>.v..
      .>.v...
      ...>...
      .......
      v......
    INPUT

    expect(subject.simulate(small_input, 4)[0]).to eq expected
  end

  it "does a medium simulation right" do
    expected = <<~INPUT.chomp
..>>v>vv..
..v.>>vv..
..>>v>>vv.
..>>>>>vv.
v......>vv
v>v....>>v
vvv.....>>
>vv......>
.>v.vv.v..
    INPUT

    expect(subject.simulate(medium_input, 58)[0]).to eq expected
  end
end
