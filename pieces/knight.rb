require_relative '../modules/steppable.rb'

class Knight < Piece
  include Steppable

  DELTAS = [[2,1], [1, 2], [-1, -2], [-2,-1],[-2,1],[1,-2],[-1,2],[2,-1]]

  def possible_moves
    possible_steps(DELTAS)
  end

end
