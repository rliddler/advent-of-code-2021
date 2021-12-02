class Day

  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def a input
    input.lines.map(&:to_i).each_cons(2).reduce(0) do |acc, window|
      window[0] < window[1] ? acc + 1 : acc
    end
  end

  def b input
    input.lines.map(&:to_i).each_cons(4).reduce(0) do |acc, window|
      window[0..2].sum < window[1..4].sum ? acc + 1 : acc
    end
  end
end
