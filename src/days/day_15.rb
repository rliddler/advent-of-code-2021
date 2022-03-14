class Day

  def call input
  end

  def a input
    grid = input.lines.map do |line|
      line.strip.chars.map(&:to_i)
    end

    start = Node.new([0,0], grid[0][0])
    goal = Node.new([@height-1, @width-1], grid[@height-1, @width-1])

    in_queue = {"0,0" => start}
    done_queue = {}

    while !in_queue.empty?
      key, current = in_queue.min_by {|key, node| node.f }
      in_queue.delete(key)

      # get the next possible nodes
      neighbours = neighbours_for_node(current)

      # Check each neighbour to see if they are in the done pile
    end
  end

  def neighbours_for_node node
    x,y = node.position

    a = Node.new([x+1, y], grid[y][x+1]) if x < @width
    b = Node.new([x-1, y], grid[y][x-1]) if x > 0
    c = Node.new([x, y+1], grid[y+1][x]) if y < @height
    d = Node.new([x, y-1], grid[y-1][x]) if y > 0

    [a,b,c,d].compact
  end

  # Should only use this when not able to go diagonally
  def manhattan_distance a, b
    (a.x - b.x).abs + (a.y - b.y).abs
  end
end

class Node
  attr_reader :key, :f, :position, :value

  def initialize position, value
    @position = position
    @key = "#{position[0]},#{position[1]}"
    @value = value
    @f = 0
  end
end
