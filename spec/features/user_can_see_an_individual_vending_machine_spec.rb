require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'they see the name of all snacks associated with that vending machine along with their price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = dons.snacks.create(name: 'pretzels', price: "$0.99")
    snack_2 = dons.snacks.create(name: 'brownie bites', price: "$1.99")
    snack_3 = dons.snacks.create(name: 'mini donuts', price: "$1.99")

    visit machine_path(dons)

    expect(page).to have_content(snack_1.name)
    expect(page).to have_content(snack_1.price)
    expect(page).to have_content(snack_2.name)
    expect(page).to have_content(snack_2.price)
    expect(page).to have_content(snack_3.name)
    expect(page).to have_content(snack_3.price)
    # save_and_open_page
  end

  scenario 'they see the average price for all the snacks in that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack_1 = Snack.create(name: 'pretzels', price: 1)
    snack_2 = Snack.create(name: 'brownie bites', price: 2)
    snack_3 = Snack.create(name: 'mini donuts', price: 1)
    dons.snacks << snack_1
    dons.snacks << snack_2
    dons.snacks << snack_3

    visit machine_path(dons)

    expect(page).to have_content("Average Price: $#{dons.average_price_of_snacks.round(2)}")
    save_and_open_page

  end
end
