class Day

  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def parse_input input
    parts = input.split("\n\n")

    template = parts[0].strip.chars
    pairs = parts[1].lines.reduce({}) do |acc, line|
      pair, insert = line.split(" -> ").map(&:strip)
      acc[pair] = insert
      acc
    end

    [template, pairs]
  end

  def a input
    template, pairs = parse_input(input)

    # Go through the template X times inserting matches in
    template = inject_pairs(10, template, pairs)

    # Now need to count the elements
    groups = template.reduce(Hash.new(0)) {|acc, ele| acc[ele] += 1; acc }

    max_key, max_val = groups.max_by {|k,v| v }
    min_key, min_val = groups.min_by {|k,v| v }

    max_val - min_val
  end

  def b input
    template, pairs = parse_input(input)

    # Go through the template X times inserting matches in
    template = inject_pairs(40, template, pairs)

    # Now need to count the elements
    groups = template.reduce(Hash.new(0)) {|acc, ele| acc[ele] += 1; acc }

    max_key, max_val = groups.max_by {|k,v| v }
    min_key, min_val = groups.min_by {|k,v| v }

    max_val - min_val
  end

  def inject_pairs x, template, pairs
    x.times do
      temp_bucket = []

      template.each_cons(2) do |char_pair|
        match = pairs[char_pair.join]

        # always put the first in.
        temp_bucket << char_pair[0]

        # Add the middle insert if we have a match
        temp_bucket << match if match
      end

      # at the end we will be missing the last char, chuck it on
      temp_bucket << template.last

      # Override the template for this round!
      template = temp_bucket
    end

    template
  end
end

###
# ""
# "NBBBCNCCNBBNBNBBCHBHHBCHB"
# "NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB"
#
# Template:     NNCB
# After step 1: NCNBCHB
#               NCNBCHB
# After step 2: NBCCNBBBCBHCB
#               NBCCNBBBCBHCB
# After step 3: NBBBCNCCNBBNBNBBCHBHHBCHB
# After step 4: NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB
