require "support/login_helper"
require "rails_helper"

describe "User do specific actions:" do
  let!(:user) { create(:user) }
  let!(:card) { create(:card) }
  let!(:deck) { create(:deck) }
  before(:each) do
    login("ex@mail.com", "1111")
    card.update_attribute(:review_date, Date.today - 1.day)
    user.update_attribute(:locale, "ru")
  end

  context "checks translations -" do
    before(:each) do
      visit root_path
    end

    it "success" do
      fill_in :user_translation, with: "Mantle"
      click_button "Попробовать"
      expect(page).to have_content "Правильный ответ!"
    end

    it "error" do
      fill_in :user_translation, with: "wrong staff"
      click_button "Попробовать"
      expect(page).to have_content "Неправильно!"
    end

    it "detect typos" do
      fill_in :user_translation, with: "Mantel"
      click_button "Попробовать"
      expect(page).to have_content "произошла ошибка"
    end
  end

  context "checks decks -" do
    before(:each) do
      card.update_attributes(deck_id: 2)
      visit decks_path
      click_link "Сделать текущей"
    end

    it "see current deck" do
      expect(page).to have_content "Текущая колода: magic"
    end

    it "don't see other decks cards" do
      expect(page).not_to have_content "Мантия"
    end

    it "see all cards when reset current deck" do
      card.update_attributes(deck_id: 1)
      visit decks_path
      click_link "Сбросить текущую колоду"
      expect(page).to have_content "Мантия"
    end
  end
end
