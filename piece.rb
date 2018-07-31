
class Piece

  attr_accessor :current_pos, :board, :piece_color, :pos_color
  def initialize(piece_color,  board, current_pos = nil, pos_color = nil)
    @piece_color = piece_color
    @current_pos = current_pos
    @board = board
    @pos_color = pos_color #:black ; <Rook>
  end

  def init_move(destination)
    board[current_pos] = pos_color unless current_pos == nil
    extract_color(destination) #memmorize the position color for next step
    board.delete_at(destination)
    board[destination] = self
    self.current_pos = destination
  end

  def move(destination)
    prev_pos = current_pos

    board[current_pos] = pos_color unless current_pos == nil
    extract_piece(destination)
    board.delete_at(destination)
    board[destination] = self
    self.current_pos = destination
    result = board.check_on?(piece_color)
    # debugger
    if result == false
      board[current_pos] = pos_color unless current_pos == nil
      board.replace(pos_color, piece_color) if pos_color.class != Symbol
      extract_color(prev_pos)
      board[prev_pos] = self
      self.current_pos = prev_pos


      board[current_pos] = pos_color unless current_pos == nil
      extract_piece(destination)
      board.delete_at(destination)
      board[destination] = self
      # debugger
      self.current_pos = destination
      # debugger
    else
      board[current_pos] = pos_color unless current_pos == nil
      board.replace(pos_color, piece_color) if pos_color.class != Symbol
      extract_color(prev_pos)
      board[prev_pos] = self
      self.current_pos = prev_pos
      raise SelectionError.new("You have to protect your King!")

    end
  end

  def extract_color(pos)
    # @pos_color = board[pos]
    if board[pos].class == Symbol
      self.pos_color = board[pos]
    else
      self.pos_color = board[pos].pos_color
    end
  end

  def extract_piece(pos)
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

class SelectionError < StandardError

end

class DeselectionError < StandardError
end
