class Day

  def call input
    input = input.lines.filter {|x| x!="\n"}
    balls = input[0].strip.split(",").map(&:to_i)

    grids = input[1..].each_slice(5).map do |grid_lines|
      Grid.new(grid_lines)
    end

    # Technically B receives a partly filled out grid already
    # We would have to recreate or deep copy the grids variable
    return "#{a(balls, grids)}, #{b(balls, grids)}"
  end

  def a balls, grids
    winner = nil

    balls.each do |ball|
      grids.each do |grid|
        grid.mark_ball ball

        if grid.winning?
          winner = grid
          break
        end
      end

      break if winner
    end

    winner.score
  end

  def b balls, grids
    win_limit = grids.size - 1
    winners_so_far = 0

    last_winner = nil

    balls.each do |ball|
      grids.each do |grid|
        next if grid.winning?
        grid.mark_ball ball

        if grid.winning?
          last_winner = grid
          winners_so_far += 1
          break if winners_so_far == win_limit
        end
      end

      break if winners_so_far == win_limit
    end

    last_winner.score
  end
end

class Grid
  Square = Struct.new(:number, :called)

  attr_reader :rows, :last_ball

  def initialize lines
    @rows = lines.map do |line|
      line.strip.split.map(&:to_i).map { |a| Square.new(a, 0) }
    end
  end

  def mark_ball ball
    @last_ball = ball

    @rows.each do |row|
      row.each do |sqr|
        if sqr.number == ball
          sqr.called = 1
          return
        end
      end
    end
  end

  def winning?
    @rows.each do |row|
      return true if row.sum {|a| a.called } == row.length
    end

    @rows.transpose.each do |col|
      return true if col.sum {|a| a.called } == col.length
    end

    false
  end

  def score
    @last_ball * @rows.reduce(0) do |acc, row|
      acc + row.filter {|x| x.called == 0 }.sum { |x| x.number }
    end
  end
end
