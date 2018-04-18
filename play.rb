require 'rspec'

# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

class Heaven
  attr_reader :cells

  def initialize(novae)
    @cells = novae.flatten
  end

  def ==(other)
    return false unless other.class == self.class

    self.cells == other.cells
  end

  def mush
    Heaven.new(
      cells.
        flatten.
        group_by(&:coordinates).
        values.
        map do |cell_list|
          cell_list.detect(&:alive?) || cell_list.first
        end
    )
  end
end

class World
  attr_reader :cells

  def initialize(cells = nil)
    @cells = cells || []
  end

  def tick
    World.new
  end

  def explode
    cells.map(&:explode)
  end

end

class Cell
  attr_reader :alive, :coordinates

  def initialize(x, y)
    @alive = true
    @coordinates = [x, y]
  end

  def alive?
    alive
  end

  def kill!
    @alive = false
    self
  end

  def explode
    x, y = coordinates
    [
      Cell.new(x - 1, y - 1).kill!,
      Cell.new(x - 1, y + 0).kill!,
      Cell.new(x - 1, y + 1).kill!,
      Cell.new(x + 0, y - 1).kill!,
      Cell.new(x + 0, y + 0),
      Cell.new(x + 0, y + 1).kill!,
      Cell.new(x + 1, y - 1).kill!,
      Cell.new(x + 1, y + 0).kill!,
      Cell.new(x + 1, y + 1).kill!
    ]
  end

end

RSpec.describe 'Conway' do
  describe 'Heaven' do
    subject { Heaven.new([Cell.new(0,0).explode]) }

    it 'can be initialized with novae' do
      expect(subject.cells.length).to eql(9)
    end

    describe '#mush' do
      subject { Heaven.new([cell_1, cell_2, cell_3]) }
      let(:cell_1) { Cell.new(0, 0) }
      let(:cell_2) { Cell.new(1, 1) }
      let(:cell_3) { Cell.new(1, 1).kill! }

      specify 'three nearby cells mush correctly' do
        expect(subject.mush).to eq(Heaven.new([cell_1, cell_2]))
      end
    end
  end

  describe 'World' do
    subject { World.new }

    describe '#initialize' do
      it 'allows cells to be initialized' do
        cell = Cell.new(0,0)
        expect(World.new([cell]).cells).to eql([cell])
      end
    end

    describe '#tick' do
      it 'returns another World' do
        expect(subject.tick).to be_instance_of(World)
      end
    end


    describe '#cells' do
      it 'returns list of cells in the world' do
        expect(subject.cells).to eql([])
      end
    end

    describe '#explode' do
      it "explodes every cell in the world" do
        subject.cells.each do |cell|
          expect(cell).to receive(:explode)
        end

        subject.explode
      end
    end

  end

  describe 'Cell' do
    subject { Cell.new(0,0) }

    describe '#initialize' do
      it 'takes coordinates' do
        expect(Cell.new(1, 2).coordinates).to eql([1,2])
      end
    end

    describe '#alive?' do
      context 'when alive' do
        it 'should be true' do
          expect(subject).to be_alive
        end
      end
    end

    it 'can be killed' do
      expect { subject.kill! }.to change { subject.alive? }.from(true).to(false)
    end

    describe '#explode' do
      it 'returns a list of nine cells' do
        expect(subject.explode.length).to eql(9)
      end

      specify '8 of the 9 cells are dead' do
        expect(subject.explode.select(&:alive?).length).to eql(1)
      end
    end

  end
end
