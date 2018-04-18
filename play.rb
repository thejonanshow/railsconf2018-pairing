require 'rspec'
# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

class Grid
  attr_reader :size

  def initialize(size: 10)
    @size = size
  end

  def get(lat, long)
    
  end

  def cells
    []
  end
end

class Cell
  attr_reader :alive

  def initialize
    @alive = true
  end

  def alive?
    alive
  end

  def kill
    @alive = false
    self
  end
end

RSpec.describe "Something" do
  describe "Grid" do
    it "exists" do
      expect(Grid.new).to be
    end

    it "size equals the parameter given" do
      expect(Grid.new(size: 48).size).to eq(48)
    end

    it "has cells" do
      expect(Grid.new.cells).to eq([])
    end

    it "returns the cell at the given coordinates" do
      expect(Grid.new.get(0,0)).to_not be nil
    end

    xit "is initialized with half of the maximum cells" do
      expect(Grid.new(size: 10).cell_count).to eq(50)
    end
  end

  describe "Cell" do
    it "is alive when it's initialized" do
      expect(Cell.new.alive?).to be
    end

    it "dies when we kill it" do
      expect(Cell.new.kill.alive?).to eq(false)
    end
  end
end
