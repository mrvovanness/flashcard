require "support/login_helper"
require "rails_helper"

describe "User" do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck) }
  before(:each) do
    login("ex@mail.com", "1111")
  end
  context "creates card" do
    before(:each) do
      visit root_path
      click_link "Добавить карточку"
      fill_in "card_original_text", with: "Go"
      fill_in "card_translated_text", with: "Вперед"
    end
    it "inside new deck" do
      fill_in "new_deck_name", with: "English"
      click_button "Сохранить"
      expect(page).to have_content "Ты создал новую карточку в колоде English"
    end
  end
end
