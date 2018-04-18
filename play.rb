require 'rspec'

class Cell
  attr_accessor :alive

  def initialize
    @alive = true
  end

  def kill
    @alive = false
  end

  def dead?
    !alive
  end

  def alive?
    alive
  end
end

# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

RSpec.describe 'Conway' do
  describe Cell do
    subject { Cell.new }
    
    it "can be killed" do
      expect{ subject.kill }.to change { subject.dead? }.from(false).to(true)
    end
  end
end
