class Day

  def call input, steps_a=100
    raw_octs = input.lines.map {|line| line.strip.chars.map(&:to_i) }
    octs_a = build_octopi(raw_octs)
    octs_b = build_octopi(raw_octs)

    return "#{a(octs_a, steps_a)}, #{b(octs_b)}"
  end


  def a octs, steps=100
    flat_octs = octs.flatten

    steps.times do
      flat_octs.each {|o| o.increase_energy }
      flat_octs.each {|o| o.flash! if o.should_flash?  && o.not_tired?}
      flat_octs.each {|o| o.reset }
    end

    flat_octs.sum {|o| o.flashes }
  end

  def b octs
    flat_octs = octs.flatten
    step_number = 0

    loop do
      step_number += 1
      flat_octs.each {|o| o.increase_energy }
      flat_octs.each {|o| o.flash! if o.should_flash?  && o.not_tired?}

      break if flat_octs.none? {|o| o.not_tired? }

      flat_octs.each {|o| o.reset }
    end

    return step_number
  end

  def build_octopi raw_octs
    octs = Array.new(raw_octs.size) { Array.new(raw_octs.first.size) { Octopus.new() }}

    height = raw_octs.size - 1
    width = raw_octs.first.size - 1

    raw_octs.each_with_index do |row, i|
      row.each_with_index do |_, j|
        oct = octs[i][j]

        # build the compass directions
        nw, n, ne, e, se, s, sw, w = nil

        nw = octs[i-1][j-1] if i > 0 && j > 0
        se = octs[i+1][j+1] if i < height && j < width

        n = octs[i-1][j] if i > 0
        s = octs[i+1][j] if i < height

        w = octs[i][j-1] if j > 0
        e = octs[i][j+1] if j < width

        ne = octs[i-1][j+1] if i > 0 && j < width
        sw = octs[i+1][j-1] if i < height && j > 0

        oct.link(raw_octs[i][j], nw, n, ne, e, se, s, sw, w)
      end
    end

    octs
  end
end

class Octopus
  attr_reader :flashes, :energy, :flashed

  def link(energy, nw, n, ne, e, se, s, sw, w)
    @flashed = false
    @flashes = 0
    @energy = energy

    @nw = nw
    @n = n
    @ne = ne
    @e = e
    @se = se
    @s = s
    @sw = sw
    @w = w
  end

  def reset
    if @flashed
      @energy = 0
      @flashed = false
    end
  end

  def increase_energy
    @energy += 1
  end

  def should_flash?
    @energy > 9
  end

  def not_tired?
    !@flashed
  end

  def flash!
    @flashes += 1
    @flashed = true

    # increase all neighbours
    neighbours.each do |o|
      o.increase_energy

      # Only trigger those that need it
      if o.should_flash? && o.not_tired?
        o.flash!
      end
    end
  end

  def neighbours
    [@nw, @n, @ne, @e, @se, @s, @sw, @w].compact
  end
end
