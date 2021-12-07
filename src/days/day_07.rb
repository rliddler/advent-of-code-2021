class Day

  def call input
    positions = input.lines.first.split(",").map(&:to_i)
    return "#{a(positions)}, #{b(positions)}"
  end

  def a positions
    # We can actually just get the median in effect as it would
    # be the minimal distance from all points?
    #
    #   x - - - - - x - | - x - - - - x
    #

    median = positions.sort[positions.size / 2]
    positions.reduce(0) {|acc, pos| acc + (pos - median).abs }
  end

  def b positions
    # I think what we're calculating here is the mean?
    # There is an increased cost for moving away from the most
    # average line?
    #    x
    #    |
    # - - - - - - -
    #       |
    #       |
    #       x

    mean = positions.sum / positions.size.to_f
    floor = positions.reduce(0) { |acc, pos| acc + gauss_cost((pos - mean.floor).abs) }
    ceil = positions.reduce(0) { |acc, pos| acc + gauss_cost((pos - mean.ceil).abs) }

    [floor, ceil].min
  end

  def gauss_cost val
    val * (val+1) / 2
  end
end
