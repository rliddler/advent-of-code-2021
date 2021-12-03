class Day

  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def a input
    readings = input.lines.map {|line| line.strip.chars }
    counts = column_counts(readings, false)

    num = counts.join.to_i(2)
    flipped = counts.map{|x| x == "0" ? "1" : "0" }.join.to_i(2)

    num * flipped
  end

  def b input
    readings = input.lines.map {|line| line.strip.chars }

    oxygen = filter_by_bits(readings, false)
    c02 = filter_by_bits(readings, true)

    oxygen * c02
  end

  def column_counts array, flip
    mapped = array.transpose.map do |arr|
      arr.count{|x| x == "0"} > arr.size/2 ? "0" : "1"
    end

    mapped.map! { |x| x == "0" ? "1" : "0" } if flip
    mapped
  end

  def filter_by_bits readings, flip
    list = readings.dup
    index = 0

    loop do
      col_counts = column_counts(list, flip)
      list.filter! {|bits| bits[index] == col_counts[index] }

      break if list.size == 1
      index += 1
    end

    list[0].join.to_i(2)
  end
end
