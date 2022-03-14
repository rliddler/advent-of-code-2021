class Day

  def call input
    numbers = "11111111111111"

    # number = 99999999999999
    # while true do
    #   number_s = number.to_s
    #   number -= 1

    #   if number_s.index('0') != nil
    #     puts "skipping: #{number_s}"
    #     next
    #   end

    #   puts "n: #{number_s}"
    #   result = run(number_s, input)

    #   if result['z'] == 0
    #     puts "Found answer: #{number_s}"
    #     break
    #   end
    # end


    run(numbers, input)
  end

  def run numbers, input
    @input_numbers = numbers.chars.map(&:to_i)
    @store = {
      'w' => 0,
      'x' => 0,
      'y' => 0,
      'z' => 0,
    }

    lines = input.lines.map {|line| line.strip.split(" ") }

    lines.each do |line_parts|
      process_instruction(line_parts)
    end

    @store
  end

  def process_instruction parts
    instruction = parts[0]
    left = parts[1]

    if instruction == "inp"
      @store[left] = @input_numbers.shift
      return
    end

    # Every other instruction has a right component
    right = parse_right parts[2]

    case instruction
    when "add"
      # Add a to b and store inside the first
      @store[left] += right
    when "mul"
      # multiply the values together and store in the first
      @store[left] *= right
    when "div"
      # multiply the values together and store in the first
      @store[left] /= right
    when "mod"
      # mod the values together and store in the first
      @store[left] %= right
    when "eql"
      # compare values, store 1 in left if true, 0 if false
      eql = @store[left] == right
      @store[left] = eql ? 1 : 0
    else
      puts "Could not understand instruction: #{instruction[0]}"
    end
  end

  def parse_right val
    @store.key?(val) ? @store[val] : val.to_i
  end
end
