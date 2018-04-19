require 'minitest/autorun'
require 'minitest/pride'

# lit < 2, dark
# lit 2/3, lit
# lit with > 3, dark
# dark with == 3, spawn

class Blob
  attr_reader :globe

  def initialize(globe)
    @globe = globe
  end

  def neighbors
    4.times.map { Blob.new }
  end
end

class SnowGlobe
  def initialize(size)
    @blobs = Array.new(size * size) { Blob.new(self) }
    @size = size
  end

  def blobs
    @blobs
  end
end

class TestBlob < Minitest::Test
  def setup
    @globe = SnowGlobe.new(5)
    @blob = @globe.blobs.sample
  end

  def test_globe
    assert_include @blob.globe.blobs, @blob
  end

  def test_neighbors
    assert_equal 4, @blob.neighbors.size
    assert @blob.neighbors.all? { |blob| blob.is_a? Blob }
  end
end

class TestSnowGlobe < Minitest::Test
  def setup
    @globe = SnowGlobe.new 5
  end

  def test_initialize
    assert_equal 25, @globe.blobs.size
  end
end
