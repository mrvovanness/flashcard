require 'rails_helper'

describe Card do
  let! (:card) { create(:card) }

  it "check matching words" do
    expect(card.check_translation("Mantle")).to be 0
  end

  it "check mathing words regardless language and case" do
    expect(card.check_translation("mANtlE")).to be 0
  end

  it "check unmatching words" do
    expect(card.check_translation("future")).to be 5
  end

  it "pass nonequal words" do
    expect(card.errors.any?).to be false
  end

  it "don't pass equal words" do
    card = Card.create(original_text: "Fall", translated_text: "Fall")
    expect(card.errors.any?).to be true
  end

  context "update review date" do

    it "and decrease number of cards" do
      succ_card = Card.pending.first
      expect {
        succ_card.check_translation(succ_card.original_text)
      }.to change { Card.pending.count }.by(-1)
    end

    it "on 12 hour after first check" do
      expect { card.check_translation(card.original_text) }.to change {
        card.review_date.beginning_of_hour
      }.by(12.hours)
    end

    it "on 3 days after second check" do
      card.update_attribute(:number_of_reviews, 1)
      expect { card.check_translation(card.original_text) }.to change {
        card.review_date.beginning_of_day
      }.by(3.days)
    end

    it "on 1 week after third check" do
      card.update_attribute(:number_of_reviews, 2)
      expect { card.check_translation(card.original_text) }.to change {
        card.review_date.beginning_of_week
      }.by(1.week)
    end

    it "on 2 week after forth check" do
      card.update_attribute(:number_of_reviews, 3)
      expect { card.check_translation(card.original_text) }.to change {
        card.review_date.beginning_of_week
      }.by(2.week)
    end

    it "on a month after fifth check" do
      card.update_attribute(:number_of_reviews, 4)
      expect { card.check_translation(card.original_text) }.to change {
        card.review_date.beginning_of_month
      }.by(1.months)
    end
    it "on a 12 hours from high level if three errors occurs" do
      card.update_attributes(number_of_reviews: 4)
      card.check_translation("bad staff")
      card.check_translation("bad staff")
      card.check_translation("bad staff")
      expect(card.number_of_reviews).to eq (0)
    end
  end
end
