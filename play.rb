require 'rspec'

# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

class Grid
  attr_reader :size, :cells

  def initialize(size: 1337, cells: [Cell.new])
    @size = size
    @cells = cells
  end
end

class Cell
  def initialize(dead = true)
    @dead = dead
  end

  def dead?
    @dead
  end

  def alive?
    !@dead
  end

  def revive
    self.tap do
      @dead = false
    end
  end
end

RSpec.describe 'Conway' do
  describe Grid do
    subject { described_class.new }

    it 'has a specified size' do
      expect(subject.size).not_to be nil
    end

    it 'has cells' do
      expect(subject.cells.sample).to be_a_kind_of(Cell)
    end
  end

  describe Cell do
    subject { described_class.new }
    let(:living_cell) { described_class.new(false) }

    it 'is initialized dead' do
      expect(subject).to be_dead
    end

    it 'can be initialized as alive' do
      expect(living_cell).to be_alive
    end

    it 'can be revived!' do
      expect(subject.revive).to be_alive
    end
  end
end














