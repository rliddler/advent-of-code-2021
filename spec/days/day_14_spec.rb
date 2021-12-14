require "spec_helper"
require_relative "../../src/days/day_14"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    INPUT
  }

  it "does a smaller simualtion right" do
    expect(subject.a(input)).to eq 1588
  end

  it "does a bigger simualtion right" do
    expect(subject.b(input)).to eq 2188189693529
  end
end
