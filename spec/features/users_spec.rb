require "support/login_helper"
require "rails_helper"

describe "User" do
  let!(:user) { create(:user) }
  context "creates card" do
    before(:each) do
      login("ex@mail.com", "1111")
      visit root_path
      click_link "Add Card"
      fill_in "card_original_text", with: "Go"
      fill_in "card_translated_text", with: "Вперед"
      fill_in "new_deck_name", with: "English"
      click_button "Create pretty card"
    end
    it "inside new deck" do
      expect(page).to have_content "You just created card"
    end
    it "with correct review date" do
      expect(page).to have_content "#{ I18n.l(
      DateTime.now.in_time_zone('UTC'), format: '%-d %B %H:%M')}"
    end
  end
  context "changes language" do
    it "before login" do
      visit root_path
      click_link "ru"
      expect(page).to have_content "Флэшкарточкер"
    end
  end
end
