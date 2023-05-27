
class Node
  attr_accessor :place, :taken, :knight_moves
  
  def initialize(place)
    @place = place
    @taken = nil
    @knight_moves = []
  end

  def node_on_board(node_array)
    return true if (node_array[0] >= 1 && node_array[1] >= 1) && (node_array[0] <= 8 && node_array[1] <= 8)
    false
  end

end


class Board < Node
  attr_accessor :board
  def initialize()
    @board = []
    create_nodes
    add_possible_knight_moves
  end

  def print_board
    @board.each {|node| p node }
  end

  def create_nodes()
    9.times do |column| 
      9.times do |row|
        @board << Node.new([column, row]) unless column == 0 || row == 0
      end
    end
    
  end

  def get_node(node_as_array)
    for node in @board
      return node if node.place == node_as_array
    end
    false
  end
  
  def change_node
    @board.each {|node| yield(node)}
  end

  def add_possible_knight_moves()
    change_node do |node|
    x, y = node.place[0], node.place[1]
    possible_nodes = [[x+1, y+2], [x+1, y-2], [x-1, y-2], [x-1, y+2], [x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1]]
    possible_nodes.each {|move| node.knight_moves << move if node_on_board(move) }
    end
  end

  def breadth_first_search(node_as_array, node_to_look_for)
    nodes_to_visit = []
    nodes_visited = []
    get_node(node_as_array).knight_moves.each {|node| nodes_to_visit << node}
    nodes_visited << node_as_array
    i = 0
    while nodes_to_visit.length > 0 do
      i+=1
      current_node = nodes_to_visit.shift
      nodes_visited << current_node
      return [current_node, nodes_visited.uniq] if current_node == node_to_look_for
      get_node(current_node).knight_moves.each {|node| nodes_to_visit << node}
    end
  end 

  def find_parent(node, array)
    array.each {|parent| return parent if get_node(parent).knight_moves.include?(node) }
  end

  def knight_moves(starting_square, desired_square)
    results = breadth_first_search(starting_square, desired_square)
    node_found, nodes_visited = results[0], results[1]
    path, check_node = [], node_found
    path << node_found
    
    while check_node != starting_square do
      parent = find_parent(check_node, nodes_visited)
      path << parent
      check_node = parent
    end
    puts "You made it in #{path.length - 1} moves! Here's your path: "
    path.reverse.each {|square| p square}
  end
    
end
