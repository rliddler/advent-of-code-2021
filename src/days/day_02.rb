class Day

  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def a input
    result = input.lines.reduce({horizontal: 0, depth: 0}) do |acc, line|
      instruction, amount = line.split(" ")
      amount = amount.to_i

      case instruction
      when "forward"
        acc[:horizontal] += amount
      when "down"
        acc[:depth] += amount
      when "up"
        acc[:depth] -= amount
      else
        puts "Did not know what to do with instruction: #{}"
      end

      acc
    end

    result[:horizontal] * result[:depth]
  end

  def b input
    result = input.lines.reduce({aim: 0, horizontal: 0, depth: 0}) do |acc, line|
      instruction, amount = line.split(" ")
      amount = amount.to_i

      case instruction
      when "forward"
        acc[:horizontal] += amount
        acc[:depth] += amount * acc[:aim]
      when "down"
        acc[:aim] += amount
      when "up"
        acc[:aim] -= amount
      else
        puts "Did not know what to do with instruction: #{}"
      end

      acc
    end

    result[:horizontal] * result[:depth]
  end
end
