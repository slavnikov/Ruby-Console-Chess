require_relative '../modules/slidable.rb'

class Rook < Piece
  include Slidable

  DELTAS = [[0,1], [1,0], [0,-1], [-1,0]]

  def possible_moves
    possible_slides(DELTAS)
  end

end
