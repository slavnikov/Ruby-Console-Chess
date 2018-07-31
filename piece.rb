
class Piece

  attr_accessor :current_pos, :board, :piece_color, :pos_color
  def initialize(piece_color, current_pos, board, pos_color)
    @piece_color = piece_color
    @current_pos = current_pos
    @board = board
    @pos_color = pos_color
  end

  def move(destination)
    board[current_pos] = pos_color
    extract_color(destination) #memmorize the position color for next step
    board[destination] = self
  end

  def extract_color(pos)
    @pos_color = board[pos]
  end

  def to_s
    ranks = {
      King => 'K',

    }

    letter = ranks[self.class]

    " ".colorize(:background => pos_color) +
    letter.colorize(:color => piece_color, :background => pos_color) +
    " ".colorize(:background => pos_color)
  end
end
# Queen => 'Q',
# Bishop => 'B',
# Rook => 'R',
# Pawn => 'P',
# Knight => 'H'
