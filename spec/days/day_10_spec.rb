require "spec_helper"
require_relative "../../src/days/day_10"

describe Day do
  let(:input) {
    <<~INPUT.chomp
      [({(<(())[]>[[{[]{<()<>>
      [(()[<>])]({[<{<<[]>>(
      {([(<{}[<>[]}>{[]{[(<()>
      (((({<>}<{<{<>}{[]{[]{}
      [[<[([]))<([[{}[[()]]]
      [{[{({}]{}}([{[{{{}}([]
      {<[[]]>}<{[{[{[]{()[[[]
      [<(<(<(<{}))><([]([]()
      <{([([[(<>()){}]>(<<{{
      <{([{{}}[<[[[<>{}]]]>[]]
    INPUT
  }

  let(:small_input) {
    <<~INPUT.chomp
    INPUT
  }

  it "doesn't return a corrupt char if the line is incomplete" do
    expect(subject.a("[({(<(())[]>[[{[]{<()<>>")).to eq 0
  end

  it "does the small test" do
    expect(subject.a("{([(<{}[<>[]}>{[]{[(<()>")).to eq 1197
  end

  it "calculates the score for both" do
    expect(subject.call(input)).to eq "26397, 288957"
  end
end
