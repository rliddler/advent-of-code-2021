class Day

  def call input
    puts a input
  end

  def a input
    state, iterations = simulate(input, 1000)

    puts "*********************"
    puts state

    iterations
  end

  def simulate input, max_iterations
    current_state = input.lines.map {|line| line.strip.chars }
    height = current_state.size
    width = current_state.first.size

    new_state = Array.new(height) { Array.new(width) { "." } }

    iterations = 0
    while iterations < max_iterations
      # clear the new state
      new_state.each_with_index do |row, i|
        row.each_with_index {|_, j| new_state[i][j] = "." }
      end

      # east move first
      current_state.each_with_index do |row, i|
        row.each_with_index do |val, j|
          if val == ">"
            # Is in front of us clear?
            in_front = (j+1) % width

            if row[in_front] == "."
              new_state[i][in_front] = ">"
            else
              new_state[i][j] = ">"
            end
          end
        end
      end

      # south move next
      current_state.each_with_index do |row, i|
        row.each_with_index do |val, j|
          if val == "v"
            # Is in below of us clear?
            below = (i+1) % height

            if current_state[below][j] != "v" && new_state[below][j] == "."
              new_state[below][j] = "v"
            else
              new_state[i][j] = "v"
            end
          end
        end
      end

      iterations += 1

      # Break when there is no movement
      break if current_state == new_state

      # lol swaps
      current_state, new_state = new_state, current_state
    end

    return [join_state(current_state), iterations]
  end

  def print_state state
    pp state
  end

  def join_state state
    state.map {|row| row.join}.join "\n"
  end
end
