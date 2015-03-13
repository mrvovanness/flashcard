require 'rails_helper'

describe 'filling the form' do
  let!(:card) { create(:card) }
  before do
    card.update_attribute(:review_date, Date.today - 1.day)
    visit root_path
  end

  it "opens success flash if match" do
    fill_in :user_translation, with: "Mantle"
    click_button "Проверить"
    expect(page).to have_content "Правильно"
  end

  it "opens error flash if don't match" do
    fill_in :user_translation, with: "Monte"
    click_button "Проверить"
    expect(page).to have_content "Неправильно!"
  end
end
