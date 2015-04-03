require 'support/login_helper'
require 'rails_helper'

describe 'Manipulating cards and decks' do
  let!(:user) { create(:user) }
  let!(:card) { create(:card) }
  let!(:deck) { create(:deck) }
  before(:each) do
    login("ex@mail.com", "1111")
    card.update_attribute(:review_date, Date.today - 1.day)
  end

  context "check translations" do
    before(:each) do
      visit root_path
    end

    it "opens success flash if match" do
      fill_in :user_translation, with: "Mantle"
      click_button "Проверить"
      expect(page).to have_content "Правильно"
    end

    it "opens error flash if don't match" do
      fill_in :user_translation, with: "wrong staff"
      click_button "Проверить"
      expect(page).to have_content "Неправильно!"
    end

    it "detects typos" do
      fill_in :user_translation, with: "Mantel"
      click_button "Проверить"
      expect(page).to have_content "произошла опечатка"
    end
  end

  context "switch decks" do
    before(:each) do
      card.update_attributes(deck_id: 2)
      visit decks_path
      click_link "Сделать текущей"
    end

    it "opens cards in current deck" do
      expect(page).to have_content "Текущая колода: magic"
    end

    it "hasn't other deck's cards" do
      expect(page).not_to have_content "Мантия"
    end

    it "show all cards" do
      card.update_attributes(deck_id: 1)
      visit decks_path
      click_link "Сбросить текущую колоду"
      expect(page).to have_content "Мантия"
    end
  end
end
