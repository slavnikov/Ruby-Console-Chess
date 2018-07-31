
class Piece

  attr_accessor :current_pos, :board, :piece_color, :pos_color
  def initialize(piece_color,  board, current_pos = nil, pos_color = nil)
    @piece_color = piece_color
    @current_pos = current_pos
    @board = board
    @pos_color = pos_color
  end

  def move(destination)
    board[current_pos] = pos_color unless current_pos == nil
    extract_color(destination) #memmorize the position color for next step
    board[destination] = self
    self.current_pos = destination
  end

  def extract_color(pos)
    @pos_color = board[pos]
  end

  def to_s
    ranks = {
      King => 'K',
      Queen => 'Q',
      Bishop => 'B',
      Rook => 'R',
      Pawn => 'P',
      Knight => 'H'
    }

    letter = ranks[self.class]
    " ".colorize(:background => pos_color) +
    letter.colorize(:color => piece_color, :background => pos_color) +
    " ".colorize(:background => pos_color)
  end
end
