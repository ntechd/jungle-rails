require 'rails_helper'

RSpec.feature 'Visitor navigates to home page and clicks on link to details', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name: Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario 'They can navigate from the home page to product details' do
    visit root_path

    within 'article.product header' do
      link = find('a')
      link.click
    end

    expect(page).to have_css 'article.product-detail'

     save_and_open_screenshot
  end
end
