require 'colorize'
require_relative 'board.rb'
require_relative 'cursor.rb'

class Display
  attr_accessor :board, :cursor
  def initialize
    board = Board.new
    board.fill_colors
    board.populate_board
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system("clear")
    puts "    A  B  C  D  E  F  G  H "
    board.grid.each_with_index do |row, i|
      print " #{8 - i} "
      row.each do |col|
        if col == :grey
          print "   ".colorize(:background => :grey)
        elsif col == :white
          print "   ".colorize(:background => :white)
        elsif col == :yellow
          print "   ".colorize(:background => :yellow)
        elsif col.class.superclass == Piece
          print col
        end
      end
      print " #{8 - i} "
      puts
    end
    puts "    A  B  C  D  E  F  G  H "
  end

  def show_cursor
    cursor.get_input
  end

  def move_piece(from_pos, to_pos)
    board.move_piece(from_pos, to_pos)
  end

  def empty_square?(pos)
    board[pos].class == Symbol
  end

  def check_color(pos)
    board[pos].piece_color
  end
end
