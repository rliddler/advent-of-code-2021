p = File.read(File.expand_path("#{__dir__}/../../input/days/day_07.txt")).lines.first.split(",").map(&:to_i)
gauss_cost = ->(val) { val * (val+1) / 2 }
puts "#{p.reduce(0) {|acc, pos| acc + (pos - p.sort[p.size / 2]).abs }}, #{
    [p.reduce(0) { |acc, pos| acc + gauss_cost.call((pos - (p.sum / p.size.to_f).floor).abs) },
     p.reduce(0) { |acc, pos| acc + gauss_cost.call((pos - (p.sum / p.size.to_f).ceil).abs) }].min}"
