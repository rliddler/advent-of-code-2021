class Day

  def call input
    positions = input.lines.first.split(",").map(&:to_i)
    range = 0..positions.max
    return "#{a(positions, range)}, #{b(positions, range)}"
  end

  def a positions, range
    target = range.min_by { |x| cost_to_move_a(positions, x) }
    cost_to_move_a(positions, target)
  end

  def b positions, range
    target = range.min_by { |x| cost_to_move_b(positions, x)}
    cost_to_move_b(positions, target)
  end

  def cost_to_move_a positions, target
    positions.reduce(0) { |acc, position| acc + (position - target).abs }
  end

  def cost_to_move_b positions, target
    positions.reduce(0) do |acc, position|
      # Hello Gauss summation
      diff = (position - target).abs
      acc + (diff * (diff + 1) / 2)
    end
  end
end
