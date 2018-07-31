class Piece

  attr_accessor :current_pos, :board, :piece_color
  def initialize(piece_color, current_pos, board)
    @piece_color = piece_color
    @current_pos = current_pos
    @board = board
    # @pos_color = pos_color
  end

  def  move

  end
end
