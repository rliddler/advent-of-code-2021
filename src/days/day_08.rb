require "set"

class Day
  UNIQUE_INPUT_LENGTHS = [2,3,4,7]

  LENGTH_TO_VAL = {
    2 =>"1",
    3 =>"7",
    4 =>"4",
    7 =>"8",
  }


  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def a input
    input.lines.map do |line|
      sides = line.split("|")
      output_parts = sides[1].split(" ")

      output_parts.reduce(0) do |acc, part|
        UNIQUE_INPUT_LENGTHS.include?(part.length) ? acc + 1 : acc
      end
    end.sum
  end

  def b input
    readouts = input.lines.map do |line|
      sides = line.split("|")
      input_parts = sides[0].split.map(&:chars).map(&:sort).map(&:to_set)
      mapping = map_to_vals(input_parts)

      output_parts = sides[1].split.map(&:chars).map(&:sort).map do |chars|
        mapping[chars.join]
      end

      output_parts.join.to_i
    end

    readouts.sum
  end

  def map_to_vals input_parts
    value_to_number = {}
    number_to_value = {}

    groups = input_parts.group_by(&:size)

    # The numbers we know already
    one = groups[2].first
    value_to_number[one.to_a.join] = "1"

    seven = groups[3].first
    value_to_number[seven.to_a.join] = "7"

    four = groups[4].first
    value_to_number[four.to_a.join] = "4"

    eight = groups[7].first
    value_to_number[eight.to_a.join] = "8"

    # Find the groups that are 5 letters eg: 2,3,5
    five_letters = groups[5]
    six_letters = groups[6]

    three = five_letters.find { |chars| (chars & one).size == 2 }
    value_to_number[three.to_a.join] = "3"
    five_letters.delete(three)

    six = six_letters.find { |chars| (chars & one).size == 1 }
    value_to_number[six.to_a.join] = "6"
    six_letters.delete(six)

    # now use 6 to find 2
    two = five_letters.find { |chars| (chars & six).size == 4 }
    value_to_number[two.to_a.join] = "2"
    five_letters.delete(two)

    five = five_letters.to_a.first
    value_to_number[five.join] = "5"

    # Remaining: 9 / 0 - can use 5
    nine = six_letters.find { |chars| (chars & five).size == 5 }
    value_to_number[nine.to_a.join] = "9"
    six_letters.delete(nine)

    zero = six_letters.to_a.first
    value_to_number[zero.to_a.join] = "0"

    value_to_number
  end
end
