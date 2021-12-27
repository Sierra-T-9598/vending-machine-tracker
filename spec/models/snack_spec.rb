require 'rails_helper'

RSpec.describe Snack, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :price}
  end

  describe 'relationships' do
    it { should have_many :machine_snacks }
    it { should have_many(:machines).through(:machine_snacks)}
  end

  describe 'class methods' do
    describe '::average_price' do
      it 'calculates the average price of all snacks' do
        snack_1 = Snack.create(name: 'pretzels', price: 1)
        snack_2 = Snack.create(name: 'brownie bites', price: 2)
        snack_3 = Snack.create(name: 'mini donuts', price: 1)

        expect(Snack.average_price.round(2)).to eq(1.33)
      end
    end
  end
end
