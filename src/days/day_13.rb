class Day

  def call input
    parts = input.split("\n\n")

    dots = parts[0].lines.map {|coords| coords.strip.split(",").map(&:to_i) }
    map_of_dots = dots.reduce({}) {|acc, dot| acc["#{dot[0]},#{dot[1]}"] = dot; acc }
    instructions = parts[1].lines.map {|line| line.strip.split(" ")[2].split("=") }

    return "#{a(map_of_dots, instructions)}, #{b(map_of_dots, instructions)}"
  end

  def a map_of_dots, instructions
    result = fold_paper instructions.first, map_of_dots
    result.count
  end

  def b map_of_dots, instructions

    instructions.each do |instruction|
      map_of_dots = fold_paper(instruction, map_of_dots)
      puts map_of_dots.count
    end

    width, height = 0, 0
    map_of_dots.each do |key, val|
      width = val[0] if val[0] > width
      height = val[1] if val[1] > height
    end

    puts width, height

    # need to render the result somehow
    print_out = Array.new(height+1) { Array.new(width+1) {"."} }

    map_of_dots.each do |key, dot|
      x,y = dot
      print_out[y][x] = "#"
    end

    print_out.each {|row| puts "#{row.join}" }
  end

  def fold_paper instruction, map_of_dots
    axis, raw_fold = instruction
    fold = raw_fold.to_i

    result = {}
    case axis
    when "y"
      map_of_dots.each do |key, dot|
        x,y = dot

        if y < fold
          result["#{x},#{y}"] = dot

        elsif y > fold
          new_y = fold - (y - fold)
          result["#{x},#{new_y}"] = [x,new_y]
        end
      end
    when "x"
      map_of_dots.each do |key, dot|
        x,y = dot

        if x < fold
          result[key] = dot
        elsif x > fold
          new_x = fold - (x - fold)
          result["#{new_x},#{y}"] = [new_x,y]
        end
      end
    end

    result
  end
end
