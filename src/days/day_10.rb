class Day
  LEFT = ['(', '[', '{', '<']

  RIGHT_TO_LEFT = {
    ')' => '(',
    ']' => '[',
    '}' => '{',
    '>' => '<',
  }

  LEFT_TO_RIGHT = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>',
  }

  CHAR_COST_A = {
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
  }

  CHAR_COST_B = {
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
  }

  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def a input
    lines_of_chars = input.lines.map {|line| line.strip.chars }

    errors = []
    lines_of_chars.each do |chars|
      queue = []

      chars.each do |char|
        if LEFT.include? char
          queue.push(char)
        else
          # So this must be a right char - find the matching left to remove
          in_char = RIGHT_TO_LEFT[char]
          to_match = queue.pop

          if in_char != to_match
            errors << char
            break
          end
        end
      end
    end

    errors.sum {|char| CHAR_COST_A[char] }
  end

  def b input
    lines_of_chars = input.lines.map {|line| line.strip.chars }

    # For each line build a queue and parse it
    rebuilt = lines_of_chars.map do |chars|
      queue = []

      corrupt = false
      chars.each do |char|
        if LEFT.include? char
          queue.push(char)
        else
          # So this must be a right char - find the matching left to remove
          in_char = RIGHT_TO_LEFT[char]
          to_match = queue.pop

          if in_char != to_match
            # currupt line - ignore it
            corrupt = true
            break
          end
        end
      end

      # Check if we have missing chars
      # Ignore the corrupt lines
      missing_chars = []
      unless corrupt
        while queue.size > 0
          left = queue.pop
          missing_chars << LEFT_TO_RIGHT[left]
        end
      end

      corrupt ? nil : missing_chars
    end

    scores = rebuilt.compact.map do |chars|
      chars.reduce(0) do |acc, char|
        acc * 5 + CHAR_COST_B[char]
      end
    end

    scores.sort[(scores.size-1)/2]
  end
end
