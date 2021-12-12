require "set"

class Day
  def call input
    res_a = a(input)
    res_b = b(input)

    puts "#{res_a}, #{res_b}"
  end

  def build_nodes input
    # Parse the links first and get unique set of node names
    node_names = Set.new
    links = input.lines.map do |line|
      ends = line.strip.split("-")
      node_names += ends
      ends
    end

    # Now build the nodes
    nodes = Hash.new
    node_names.each do |name|
      nodes[name] = Node.new(name)
    end

    # Now process the links and attach to the nodes
    links.each do |a, b|
      node_a = nodes[a]
      node_b = nodes[b]

      node_a.link(node_b)
      node_b.link(node_a)
    end

    nodes
  end

  def a input
    nodes = build_nodes(input)
    nodes.reject! {|key, node| node.dead_end? } # remove deadends

    routes_completed = []
    routes_queue = [Route.new([nodes["start"]]]

    # Start with the start node!
    routes_queue << Route.new([nodes["start"]])

    while routes_queue.size > 0 do
      route = routes_queue.pop
      node = route.latest

      if node.name == "end"
        routes_completed << route
        next
      end

      node.links.each do |other_node|
        if route.could_visit?(other_node)
          routes_queue.push(route.new_route_to(other_node))
        end
      end
    end

    routes_completed.size
  end

  def b input
    nodes = build_nodes(input)

    routes_completed = []
    routes_queue = [Route.new([nodes["start"]]]

    while routes_queue.size > 0 do
      route = routes_queue.pop
      node = route.latest

      if node.name == "end"
        routes_completed << route
        next
      end

      node.links.each do |other_node|
        if other_node.name == "start"
          next
        end

        if route.could_visit_multiple?(other_node)
          routes_queue.push(route.new_route_to(other_node))
        end
      end
    end

    routes_completed.size
  end
end

class Route
  attr_reader :path

  def initialize nodes, visited_twice=false
    @path = nodes
    @visited_small_twice = visited_twice
  end

  def latest
    @path[-1]
  end

  def could_visit? node
    return true if node.large
    !@path.include?(node)
  end

  def could_visit_multiple? node
    return true if node.large
    return true if !@path.include?(node)
    return true if !@visited_small_twice

    false
  end

  def new_route_to node
    visited_already = (!node.large && @path.include?(node) || @visited_small_twice)
    Route.new(@path + [node], visited_already)
  end
end

class Node
  attr_reader :name, :large, :links

  def initialize name
    @name = name
    @large = @name == @name.upcase
    @links = []
  end

  def link other_node
    @links << other_node
  end

  def dead_end?
    @links.size == 1 && !@links[0].large
  end
end
