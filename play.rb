require 'rspec'

class Board
  def initialize(living_cells, size = 10)
    soon_to_be_grid = Array.new(size * size - living_cells) { Cell.new(false) }
    soon_to_be_grid += Array.new(living_cells) { Cell.new }

    @grid = []

    soon_to_be_grid.shuffle.each_slice(size) do |row|
      @grid << row
    end
  end

  def living_cells
    @grid.flatten.select(&:alive?).count
  end

  def print_grid
    system 'clear'
    @grid.each { |row| puts row.join(' ') }
  end

  def tick
    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        count = living_neighbor_count(x, y)
      end
    end
  end

  def living_neighbor_count(x, y)
    count = 0

    [-1, 0, 1].each do |x_offset|
      [-1, 0, 1].each do |y_offset|
        next if x_offset == 0 && y_offset == 0
        next if x + x_offset < 0
        next if y + y_offset < 0
        next if x + x_offset > @grid.length - 1
        next if y + y_offset > @grid.length - 1

        count += 1 if @grid[x + x_offset][y + y_offset].alive?
      end
    end
  end
end

class Cell
  attr_accessor :alive, :secret_state

  def initialize(state = true)
    @alive = state
  end

  def kill
    @alive = false
  end

  def live!
    @alive = true
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def to_s
    alive? ? '😇' : '👿'
  end
end

RSpec.describe 'Conway' do
  describe Cell do
    subject { Cell.new }

    it "can be killed" do
      expect{ subject.kill }.to change { subject.dead? }.from(false).to(true)
    end
  end

  describe Board do
    subject { Board.new(5) }

    it "takes seed value and creates board" do
      expect(Board.new(5).living_cells).to eq(5)
    end

    it "prints to the screen" do
      expect { subject.print_grid }.to output.to_stdout
    end

    it "progresses" do
      board = Board.new(100, 10)

      expect(board.living_cells).to eq(100)
      board.tick
      expect(board.living_cells).to_not eq(100)
    end
  end
end

Board.new(20, 10).print_grid
