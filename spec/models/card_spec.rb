require 'rails_helper'

describe Card do
  let! (:card) { create(:card) }

  context "review date shifts" do
    it "1 day after first excellent answer" do
      card.check_translation("Mantle", 10)
      expect(card.interval).to be 1
    end

    it "6 days after second excellent answer" do
      2.times { card.check_translation("Mantle", 10) }
      expect(card.interval).to be 6
    end

    it "16 days after third excellent answer" do
      3.times { card.check_translation("Mantle", 10) }
      expect(card.interval).to be 16
    end

    it "15 days after third answer with time delaying" do
      3.times { card.check_translation("Mantle", 25) }
      expect(card.interval).to be 15
    end

    it "back if typos or errors occur" do
      4.times { card.check_translation("Mantle", 10) }
      card.check_translation("Montle", 10)
      expect(card.interval). to be 0
    end
  end

  context "number of reviews shifts" do
    before(:each) do
      15.times { card.check_translation("Mantle", 10) }
    end
    it "as count if no errors done" do
      expect(card.number_of_reviews).to be 15
    end

    it "back if any error done" do
      card.check_translation("wrong_stuff", 10)
      expect(card.number_of_reviews).to be 0
    end
  end

  context "e-factor shifts" do
    it "higher if right answers" do
      first_value = card.e_factor
      15.times { card.check_translation("Mantle", 10) }
      expect(card.e_factor).to be > first_value
    end

    it "lower if wrong answers" do
      first_value = card.e_factor
      15.times { card.check_translation("wrong_stuff", 10) }
      expect(card.e_factor).to be < first_value
    end
  end
end
