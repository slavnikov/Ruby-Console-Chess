require_relative '../modules/pawn_step.rb'

class Pawn < Piece
  include PawnStep

  MOVE_DELTAS_BLUE = [[-1, 0]]
  MOVE_DELTAS_RED = [[1,0]]
  KILL_DELTAS_BLUE = [[-1,-1],[-1,1]]
  KILL_DELTAS_RED = [[1,-1],[1,1]]

  def possible_moves
    if self.piece_color == :blue
      possible_steps(MOVE_DELTAS_BLUE, KILL_DELTAS_BLUE)
    else
      possible_steps(MOVE_DELTAS_RED, KILL_DELTAS_RED)
    end
  end

end
