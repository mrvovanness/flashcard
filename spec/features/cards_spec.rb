require "rails_helper"
include ActionView::Helpers::SanitizeHelper

describe "User", js: true do
  let!(:user) { create(:user) }
  let!(:card) { create(:card) }
  let!(:deck) { create(:deck) }
  before(:each) do
    login("ex@mail.com", "1111")
  end

  context "checks translations -" do
    it "gets success" do
      fill_in :check_data_user_translation, with: "Mantle"
      find("#check-button").click
      expect(page).to have_content I18n.t('card.check_success')
    end

    it "gets error" do
      fill_in :check_data_user_translation, with: "wrong staff"
      click_button "Just check it!"
      expect(page).to have_content I18n.t(
        'card.check_error', right_card: card.original_text)
    end

    it "gets typos" do
      fill_in :check_data_user_translation, with: "Mantel"
      click_button "Just check it!"
      expect(page).to have_content strip_tags(
        I18n.t( 'card.typos',
                 correct_answer: card.original_text,
                 typed_word: "Mantel"))
    end

    it "get delay alert" do
      fill_in :check_data_user_translation, with: "Mantle"
      page.execute_script("$('#timer').val(40)")
      find("#check-button").click
      expect(page).to have_content I18n.t('card.check_delay')
    end
  end

  context "switches decks -" do
    before(:each) do
      card.update_attributes(deck_id: 2)
      visit decks_path
      click_link "Set as current"
    end

    it "new deck" do
      expect(page).to have_content "Current deck: magic"
    end

    it "don't see other decks cards" do
      visit cards_path
      expect(page).not_to have_content "Мантия"
    end

    it "resets current deck" do
      card.update_attributes(deck_id: 1)
      visit decks_path
      click_link "Reset current deck"
      expect(page).to have_content "Мантия"
    end
  end
end
