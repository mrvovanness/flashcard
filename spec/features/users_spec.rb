require "support/login_helper"
require "rails_helper"

describe "User" do
  let!(:user) { create(:user) }
  context "creates card" do
    before(:each) do
      login("ex@mail.com", "1111")
      visit root_path
      click_link I18n.t(:add_card)
      fill_in "card_original_text", with: "Go"
      fill_in "card_translated_text", with: "Вперед"
      fill_in "new_deck_name", with: "English"
      click_button I18n.t(:save)
    end
    it "inside new deck" do
      expect(page).to have_content "You just created card"
    end
    it "with correct review date" do
      expect(page).to have_content "#{DateTime.now.in_time_zone('UTC')}"
    end
  end
  context "changes language" do
    it "before login" do
      visit root_path
      click_link "RU"
      expect(page).to have_content "Флэшкарточкер"
    end
  end
end
