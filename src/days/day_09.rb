require "set"


class Day
  def call input
    heights = input.lines.map {|line| line.strip.chars.map(&:to_i) }
    cells = build_cells_from_heights(heights)

    sum_of_low = low_points(cells).sum {|x| x.value + 1 }
    multiplied_basins = basins(cells).sort[-3..].reduce(:*)

    return "#{sum_of_low}, #{multiplied_basins}"
  end

  #####
  # Build "cells" from the processed heights
  # Each cell contains its own value and a link to any neighbours.
  #
  #       i-1
  # j-1, [i,j], j+1
  #       i+1
  def build_cells_from_heights heights
    cells = Array.new(heights.size) { Array.new(heights.first.size) { Cell.new() }}

    heights.each_with_index do |row, i|
      row.each_with_index do |height, j|
        cell = cells[i][j]

        up = i > 0 ? cells[i-1][j] : nil
        down = (i < heights.size - 1) ? cells[i+1][j] : nil
        left = j > 0 ? cells[i][j-1] : nil
        right = (j < row.size - 1) ? cells[i][j+1] : nil

        cell.link(heights[i][j], up, down, left, right)
      end
    end

    cells.flatten
  end

  def low_points cells
    cells.filter do |cell|
      cell.lowest_among_neighbours?
    end
  end

  #####
  # To find the basins we need to crawl all neighbours
  # which are not a "cliff" (9's are basically cliffs)
  #
  # We need to make sure we do not revisit anywhere so just
  # store a Set of places we've visited and check before queueing again
  def basins cells
    # Each basin has 1 low points (which we already have!)
    low = low_points(cells)

    low.map do |cell|
      visited = Set[cell]
      to_visit = [cell]

      while to_visit.size > 0
        current = to_visit.pop
        neighbours = current.non_tall_neighbours

        neighbours.each do |neighbour|
          if !visited.include? neighbour
            to_visit.push neighbour
            visited.add neighbour
          end
        end
      end

      # The size of a basin is just the number of cells within it
      visited.size
    end
  end
end

class Cell
  attr_reader :value

  def link(value, up, down, left, right)
    @value = value
    @up = up
    @down = down
    @left = left
    @right = right
  end

  def neighbours
    [@up, @down, @left, @right].compact
  end

  def lowest_among_neighbours?
    neighbours.none? {|other| @value >= other.value }
  end

  def non_tall_neighbours
    [@up, @down, @left, @right].filter {|x| x != nil && x.value != 9 }
  end
end
