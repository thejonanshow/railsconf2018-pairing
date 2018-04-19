require 'rspec'

# live < 2, die
# live 2/3, live
# live with > 3, die
# dead with == 3, spawn

class Oyster
  def initialize(aquarium)
    @aquarium = aquarium
  end

  def friends
    @aquarium.who_are_my_friends(self)
  end
end

class Aquarium
  def oysters
    []
  end

  def who_are_my_friends(oyster)
    
  end
end

RSpec.describe 'Conway' do
  describe Oyster do
    let(:oyster) { Oyster.new(Aquarium.new) }

    it "is an Oyster" do
      expect(oyster).to be_a Oyster
    end

    context "friends" do
      it "starts without friends" do
        expect(oyster.friends).to be_empty
      end

      it "reports on its friends" do
        expect(oyster.friends).not_to be_empty
        expect(oyster.friends.count).to be_greater_than 1
      end
    end
  end

  describe Aquarium do
    let(:aquarium) { Aquarium.new }

    it "has oysters" do
      expect(aquarium.oysters).to respond_to(:size)
    end
  end
end













