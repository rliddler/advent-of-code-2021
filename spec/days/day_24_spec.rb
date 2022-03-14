require "spec_helper"
require_relative "../../src/days/day_24"

describe Day do
  let(:input) {
    <<~INPUT.chomp
    inp z
    inp x
    mul z 3
    eql z x
    INPUT
  }

  describe "#run" do
    it "inp - stores the numbers" do
      input = "inp a\ninp z"
      expected = { "a" => 1, "z" => 2 }

      expect(subject.run("12", input)).to eq expected
    end

    it "add - adds the numbers together and stores in first" do
      input = "inp a\ninp z\nadd a z\n"
      expected = { "a" => 3, "z" => 2 }

      expect(subject.run("12", input)).to eq expected
    end

    it "mul - multiplies the numbers together and stores in first" do
      input = "inp a\ninp z\nmul a z\n"
      expected = { "a" => 6, "z" => 2 }

      expect(subject.run("32", input)).to eq expected
    end

    it "div - divides the numbers, truncates towards 0 and stores in first" do
      input = "inp a\ninp z\ndiv a z\n"
      expected = { "a" => 2, "z" => 4 }

      expect(subject.run("94", input)).to eq expected
    end

    it "mod - divides and stores the remainder in the left value" do
      input = "inp a\ninp z\nmod a z\n"
      expected = { "a" => 1, "z" => 4 }

      expect(subject.run("54", input)).to eq expected
    end

    it "eql - compares the values and stores 1 in left if true otherwise 0" do
      input = "inp a\ninp b\ninp z\neql a z\neql b z\n"
      expected = { "a" => 1, "b" => 0, "z" => 5 }

      expect(subject.run("545", input)).to eq expected
    end

    context "when the instruction is a number rather than a variable" do

      it "adds" do
        input = "inp a\nadd a 10\n"
        expected = { "a" => 11 }

        expect(subject.run("1", input)).to eq expected
      end

      it "eql" do
        input = "inp a\ninp b\neql a 5\neql b -5\n"
        expected = { "a" => 1, "b" => 0 }

        expect(subject.run("55", input)).to eq expected
      end
    end
  end
end
