require_relative '../modules/slidable.rb'

class Bishop < Piece
  include Slidable

  DELTAS = [[1,1], [1, -1], [-1, 1], [-1,-1]]

  def possible_moves
    possible_slides(DELTAS)
  end

end
