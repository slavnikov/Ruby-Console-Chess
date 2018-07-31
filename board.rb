require "colorize"
require_relative 'piece.rb'
require_relative 'require_pieces.rb'
require 'byebug'

class Board

  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8, nil)}
  end

  def fill_colors
    8.times do |i|
      8.times do |j|
        if (i + j).even?
          grid[i][j] = :white
        else
          grid[i][j] = :grey
        end
      end
    end
  end

  def render
    system("clear")
    puts "    A  B  C  D  E  F  G  H "
    grid.each_with_index do |row, i|
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

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    self.grid[row][col] = val
  end

  def move_piece(start_pos,end_pos)
    # unless valid_pos?(start_pos) && valid_pos?(end_pos)
    #   raise "It is outside the board."
    # end
    #
    # if self[start_pos] == nil
    #   raise "This is no piece at that position"
    # end
    #
    # if self[start_pos].can_move?(end_pos)
    #   raise "That piece can not move there"
    # end
    #
    # if @self[end_pos] != nil
    #   raise 'Can not kill a piece of the same color'
    # end

    # self[end_pos] = self[start_pos]
    # self[start_pos] = nil
    self[start_pos].move(end_pos)
  end

  def valid_pos?(pos)
    pos.all? {|el| 0 <= el && 7 >= el}
  end

  def populate_board
    ranks = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |i|
      ranks[i].new(:red,self).move([0,i])
      Pawn.new(:red,self).move([1,i])
      ranks[i].new(:blue,self).move([7,7 - i])
      Pawn.new(:blue,self).move([6,i])
    end
  end

  def legal_move?(from_pos, to_pos)
    self[from_pos].possible_moves.include?(to_pos)
  end
end


# p1 = King.new(:blue,[0,3], board, :grey)
# # p2 = Piece.new("black", [2,2], board)
# # board[[2,2]] = p2
# board[[0,3]] = p1
# board.render
