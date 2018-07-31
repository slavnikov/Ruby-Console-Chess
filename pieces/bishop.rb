require_relative 'slidable'
class Bishop < Piece
  include Slidable
  def own_deltas
    [[1,1], [1, -1], [-1, 1], [-1,-1]]
  end
end
