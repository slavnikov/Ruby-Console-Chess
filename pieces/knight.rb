require_relative 'steppable'
class Knight < Piece
  include Steppable
  def own_deltas
    [[2,1], [1, 2], [-1, -2], [-2,-1],[-2,1],[1,-2],[-1,2],[2,-1]]
  end
end
