class Board
  attr_accessor :board, :board
  def initialize(board)
    @board = board
  end

  def print_board
    @board.each {|row| p row}
  end

  def get_node(node_as_array)
    for node in @board
      return node if node.place == node_as_array
    end
  end
end

class Node < Board
  attr_accessor :place, :taken, :adjacent_nodes
  
  def initialize(place)
    @place = place
    @taken = nil
    @adjacent_knight_moves = []
  end
end

