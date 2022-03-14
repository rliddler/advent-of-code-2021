require "spec_helper"
require_relative "../../src/days/day_18"

describe Day do
  context "the final solution" do

    let(:input) {
      <<~INPUT.chomp
      [[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
      [[[5,[2,8]],4],[5,[[9,9],0]]]
      [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
      [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
      [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
      [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
      [[[[5,4],[7,7]],8],[[8,3],8]]
      [[9,3],[[9,9],[6,[4,9]]]]
      [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
      [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
      INPUT
    }

    let(:final_sum) {
      <<~INPUT.chomp
      [[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]
      INPUT
    }

    it "does the addition" do
      expect(subject.a(input)).to eq final_sum
    end

    it "calculates the magnitude" do
      expect(subject.magnitude(final_sum)).to eq 4140
    end
  end

  context "telling if we need to explode" do
    it "gives the right answer for if to explode" do
      expect(subject.should_explode?("[[[[[9,8],1],2],3],4]")).to be true
      expect(subject.should_explode?("[7,[6,[5,[4,[3,2]]]]]")).to be true
      expect(subject.should_explode?("[[6,[5,[4,[3,2]]]],1]")).to be true
      expect(subject.should_explode?("[[3,[2,[8,0]]],[9,[5,[4,[3,2]]]]]")).to be true

      expect(subject.should_explode?("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")).to be false
      expect(subject.should_explode?("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]")).to be false
      expect(subject.should_explode?("[1,2]")).to be false
    end
  end

  # context "adding the pairs onto one another" do
  #   let(:simple_pairs) {
  #     <<~INPUT.chomp
  #     [1,1]
  #     [2,2]
  #     [3,3]
  #     [4,4]
  #     INPUT
  #   }

  #   it "gives the right result of pairs" do
  #     expect(sum_pairs(simple_pairs)).to eq "[[[[1,1],[2,2]],[3,3]],[4,4]]"
  #   end
  # end
end
