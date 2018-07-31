require_relative '../modules/steppable.rb'
class King < Piece
  include Steppable

  # def own_deltas
  DELTAS = [[-1,1], [0,1], [1,1], [1,0],[1,-1],[0,-1],[-1,-1],[-1,0]]
  # end

  def possible_moves
    possible_steps(DELTAS)
  end

end
