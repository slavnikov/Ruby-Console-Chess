require "io/console"
require "colorize"
require_relative "board.rb"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :board
  attr_accessor :cursor_pos

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @prev_color = :white
  end

  def get_input
    board.render
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    update_pos(MOVES[key])
  end

  def update_pos(diff)
    deposit_color #deposit_color on position being left
    new_pos_x = (cursor_pos.first + diff.first) % 8
    new_pos_y = (cursor_pos.last + diff.last) % 8
    self.cursor_pos = [new_pos_x, new_pos_y]
    extract_color #extract_color of destination position
    set_highlight #set_highlight of destination position to :yellow
    get_input
  end

  def extract_color
    if board[cursor_pos].class == Symbol
      @prev_color = board[cursor_pos]
    else
      @prev_color = board[cursor_pos].pos_color
    end
  end

  def set_highlight
    if board[cursor_pos].class == Symbol
      board[cursor_pos] = :yellow
    else
      board[cursor_pos].pos_color = :yellow
    end
  end

  def deposit_color
    if board[cursor_pos].class == Symbol
      board[cursor_pos] = @prev_color
    else
      board[cursor_pos].pos_color = @prev_color
    end
  end
end
board = Board.new
board.fill_colors
board.populate_board
cursor = Cursor.new([0,0], board)
cursor.get_input
