require "colorize"
require_relative 'piece.rb'
require_relative 'require_pieces.rb'
require 'byebug'

class Board

  attr_accessor :grid, :current_player, :pieces

  def initialize
    @grid = Array.new(8) {Array.new(8, nil)}
    @current_player = nil
    @pieces = {
      blue: [],
      red: []
    }
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
    puts "It is the #{@current_player.color.to_s.upcase.colorize(:color => @current_player.color)} player's turn!"
    puts
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
    self[start_pos].move(end_pos)
  end

  def valid_pos?(pos)
    pos.all? {|el| 0 <= el && 7 >= el}
  end

  def delete_at(pos)
    pieces[:red].delete_if {|piece| piece.current_pos == pos}
    pieces[:blue].delete_if {|piece| piece.current_pos == pos}
  end

  def replace(piece, color)
    opponent_color = color == :blue ? :red : :blue
    pieces[opponent_color] << piece
  end

  def populate_board
    ranks = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    8.times do |i|
      piece1 = ranks[i].new(:red,self)
      piece1.init_move([0,i])
      self.pieces[:red] << piece1
      pawn1 = Pawn.new(:red,self)
      pawn1.init_move([1,i])
      self.pieces[:red] << pawn1
      piece2 = ranks[i].new(:blue,self)
      piece2.init_move([7,7 - i])
      self.pieces[:blue] << piece2
      pawn2 = Pawn.new(:blue,self)
      pawn2.init_move([6,i])
      self.pieces[:blue] << pawn2
    end
  end

  def legal_move?(from_pos, to_pos)
    self[from_pos].possible_moves.include?(to_pos)
  end

  def check_on?(color)
    opponent_color = color == :blue ? :red : :blue
    king_pos = pieces[color].find {|piece| piece.class == King}.current_pos

    pieces[opponent_color].any? {|piece| piece.possible_moves.include?(king_pos)}
  end
end
