class Day
  def call input
    positions = input.lines.first.split(",").map(&:to_i)

    median = positions.sort[positions.size / 2]
    mean = positions.sum / positions.size.to_f
    a = positions.reduce(0) {|acc, pos| acc + (pos - median).abs }

    gauss_cost = ->(val) { val * (val+1) / 2 }
    floor = positions.reduce(0) { |acc, pos| acc + gauss_cost.call((pos - mean.floor).abs) }
    ceil = positions.reduce(0) { |acc, pos| acc + gauss_cost.call((pos - mean.ceil).abs) }
    b = [floor, ceil].min

    return "#{a}, #{b}"
  end
end
