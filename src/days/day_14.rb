class Day

  def call input
    return "#{a(input)}, #{b(input)}"
  end

  def parse_input input
    parts = input.split("\n\n")

    template = parts[0].strip.chars
    pair_rules = parts[1].lines.reduce({}) do |acc, line|
      pair, insert = line.split(" -> ").map(&:strip)

      # When inserted you get 2 pairs essentially added
      acc[pair] = [pair[0] + insert, insert + pair[1]]
      acc
    end

    [template, pair_rules]
  end

  def a input
    template, pair_rules = parse_input(input)

    poly = Hash.new(0)
    template.each_cons(2) {|char_pair| poly[char_pair.join] += 1 }

    poly = inject_pairs(10, poly, pair_rules)
    count_results(poly, template)
  end

  def b input
    template, pair_rules = parse_input(input)

    poly = Hash.new(0)
    template.each_cons(2) {|char_pair| poly[char_pair.join] += 1 }

    poly = inject_pairs(40, poly, pair_rules)
    count_results(poly, template)
  end

  def count_results poly, template
    counts = Hash.new(0)
    poly.each do |pair, count|
      counts[pair[0]] += count
      counts[pair[1]] += count
    end

    # the first and last character will have not been counted twice?
    counts[template.last] += 1
    counts[template.first] += 1

    sorted_counts = counts.values.sort

    (sorted_counts.last - sorted_counts.first) / 2
  end

  def inject_pairs x, poly, pair_rules
    x.times do
      newpoly = Hash.new(0)

      # Iterate over the current pairs
      poly.each do |pair, count|
        pairs_created = pair_rules[pair]

        newpoly[pairs_created[0]] += count
        newpoly[pairs_created[1]] += count
      end

      poly = newpoly
    end

    poly
  end
end
