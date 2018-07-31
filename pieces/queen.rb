require_relative '../modules/slidable.rb'

class Queen < Piece
  include Slidable

  DELTAS = [[-1,1], [0,1], [1,1], [1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]

  def possible_moves
    possible_slides(DELTAS)
  end

end
