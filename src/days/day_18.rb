class Day

  def a input
    lines = input.lines
    arrays = lines.each { |line| eval(line) }

  end

  # def should_explode? pairs
  #   nested_count = 0
  #   pairs.chars.each do |char|
  #     nested_count += 1 if char == "["
  #     nested_count -= 1 if char == "]"

  #     return true if nested_count > 4
  #   end

  #   false
  # end

  # def should_split?

  # end

end

class Node

  def initialize parent, value, left, right
    @parent = parent
    @value = value
    @left = left
    @right = right
  end

end



