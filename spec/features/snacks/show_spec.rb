require 'rails_helper'

RSpec.describe 'When a user visits the snack show page' do
  before(:each) do
    @owner = Owner.create(name: "Sam's Snacks")
    @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
    @marks  = @owner.machines.create(location: "Mark's Margs")
    @snack_1 = Snack.create(name: 'pretzels', price: 1)
    @snack_2 = Snack.create(name: 'brownie bites', price: 2)
    @snack_3 = Snack.create(name: 'mini donuts', price: 1)
    @dons.snacks << @snack_1
    @dons.snacks << @snack_2
    @dons.snacks << @snack_3
    @marks.snacks << @snack_1

    visit snack_path(@snack_1)
  end

  scenario 'they see the name of that snack' do
    expect(page).to have_content(@snack_1.name)
    expect(page).to_not have_content(@snack_2.name)
  end

  scenario 'they see the price for that snack' do
    expect(page).to have_content(@snack_1.price)
    expect(page).to_not have_content(@snack_2.price)
  end

  scenario 'they see a list of locations with vending machines that carry that snack' do
    expect(page).to have_content(@dons.location)
    expect(page).to have_content(@marks.location)
  end

  scenario 'they see the average price for snacks in those vending machines' do
    expect(page).to have_content(@dons.snacks.average_price.round(2))
    expect(page).to have_content(@marks.snacks.average_price.round(2))
  end

  scenario 'they see a count of the different kinds of items in that vending machine' do
    expect(page).to have_content(@dons.snacks.count)
    expect(page).to have_content(@marks.snacks.count)
  end
end
