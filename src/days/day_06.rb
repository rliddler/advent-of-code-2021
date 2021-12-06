class Day
  def call input
    fish = input.lines.first.split(",").map(&:to_i)
    return "#{a(fish)}, #{b(fish)}"
  end

  def a fishies
    simulate(fishies, 80)
  end

  def b fishies
    simulate(fishies, 256)
  end

  def simulate fishies, total_days
    fish_by_day = Array.new(9, 0)
    fishies.each { |fish| fish_by_day[fish] += 1 }

    (0..total_days-1).each do |day|
      current_day = day % 9
      new_fish_to_add = fish_by_day[current_day]
      fish_by_day[(current_day + 7) % 9] += new_fish_to_add
    end

    fish_by_day.sum
  end
end
