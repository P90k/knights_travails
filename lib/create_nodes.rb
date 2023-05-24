require_relative 'knights_travails.rb'

nodes_created = []

9.times do |column| 
  9.times do |row|
    nodes_created << Node.new([column, row])
  end
end

board = Board.new(nodes_created)