require_relative '../modules/steppable.rb'

class King < Piece
  include Steppable

  DELTAS = [[-1,1], [0,1], [1,1], [1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]

  def possible_moves
    possible_steps(DELTAS)
  end

end
