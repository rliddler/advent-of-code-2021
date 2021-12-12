require "spec_helper"
require_relative "../../src/days/day_12"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    INPUT
  }

  let(:small_input) {
    <<~INPUT.chomp
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    INPUT
  }

  let(:tiny_input) {
    <<~INPUT.chomp
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    INPUT
  }

  context "a" do
    it "does a tiny simualtion right" do
      expect(subject.a(tiny_input)).to eq 10
    end

    it "does a small simualtion right" do
      expect(subject.a(small_input)).to eq 19
    end

    it "does the simualtion right" do
      expect(subject.a(input)).to eq 226
    end
  end

  context "b" do
    it "does a tiny simualtion right" do
      expect(subject.b(tiny_input)).to eq 36
    end

    context "routes" do

      it "returns true for visiting a single cave twice" do

      end
    end
  end
end
