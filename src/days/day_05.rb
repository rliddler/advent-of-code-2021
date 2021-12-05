class Day
  def call input
    lines = parse(input)
    width = lines.max {|a,b| a.max_x <=> b.max_x}.max_x + 1
    height = lines.max {|a,b| a.max_y <=> b.max_y}.max_y + 1

    return "#{a(lines, width, height)}, #{b(lines, width, height)}"
  end

  def parse input
    input.chomp.lines.map do | line|
      parts = line.split("->").map do |part|
        part.strip.split(",").map(&:to_i)
      end

      x1, y1, x2, y2 = parts.flatten
      Line.new(x1, y1, x2, y2)
    end
  end

  def a lines, width, height
    board = Array.new(height) { Array.new(width, 0) }
    fill_in_board(board, lines, true)
  end

  def b lines, width, height
    board = Array.new(height) { Array.new(width, 0) }
    fill_in_board(board, lines, false)
  end

  def fill_in_board board, lines, skip_diagonal
    lines.each do |line|
      next if !line.straight? && skip_diagonal

      step_x, step_y = line.steps

      neg_x = line.negative_x? ? -1 : 1
      neg_y = line.negative_y? ? -1 : 1

      line.range.each do |i|
        board[line.y1 + neg_y * i * step_y][line.x1 + neg_x * i * step_x] += 1
      end
    end

    board.reduce(0) {|acc, row| acc + row.count {|x| x >= 2} }
  end
end

Line = Struct.new(:x1, :y1, :x2, :y2) do
  def max_x
    x1 >= x2 ? x1 : x2
  end

  def max_y
    y1 >= y2 ? y1 : y2
  end

  def straight?
    x1 == x2 || y1 == y2
  end

  def direction
    if x1 == x2
      :vertical
    elsif y1 == y2
      :horizontal
    else
      :diagonal
    end
  end

  def negative_x?
    x1 > x2
  end

  def negative_y?
    y1 > y2
  end

  def range
    x = 0..(x1 - x2).abs
    x.last > 0 ? x : 0..(y1 - y2).abs
  end

  def steps
    case direction
    when :horizontal
      [1,0]
    when :vertical
      [0,1]
    when :diagonal
      [1,1]
    end
  end
end
