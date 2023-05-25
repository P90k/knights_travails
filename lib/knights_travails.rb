
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
    possible_nodes = [[x+2, y+1], [x+2, y-1], [x-2, y+1], [x-2, y-1], [x+1, y+2], [x+1, y-2], [x-1, y-2], [x-1, y+2]]
    possible_nodes.each do |move|
      node.knight_moves << move if node_on_board(move)
    end
  end
  end

end
