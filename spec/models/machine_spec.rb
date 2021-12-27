require 'rails_helper'

RSpec.describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe 'relationships' do
    it {should have_many :machine_snacks}
    it {should have_many(:snacks).through(:machine_snacks)}
  end

  describe 'instance methods' do
    describe '#average_price_of_snacks' do
      it 'calculates the average price of all its snacks' do
        owner = Owner.create(name: "Sam's Snacks")
        dons  = owner.machines.create(location: "Don's Mixed Drinks")
        snack_1 = Snack.create!(name: 'pretzels', price: 1)
        snack_2 = Snack.create!(name: 'brownie bites', price: 2)
        snack_3 = Snack.create!(name: 'mini donuts', price: 1)

        dons.snacks << snack_1
        dons.snacks << snack_2
        dons.snacks << snack_3

        expect(dons.average_price_of_snacks.round(2)).to eq(1.33)
      end
    end
  end
end
