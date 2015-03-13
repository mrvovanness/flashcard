require 'rails_helper'

describe Card do
  let! (:card) { create(:card) }
  before do
    card.update_attribute(:review_date, Date.today - 1.day)
  end

  it "check matching words" do
    card = Card.create(original_text: "feature", translated_text: "фишка")
    expect(card.check_translation("feature")).to be true
  end

  it "check mathing words regardless language and case" do
    card = Card.create(original_text: "Кухня", translated_text: "Kitchen")
    expect(card.check_translation("куХНя")).to be true
  end

  it "check unmatching words" do
    card = Card.create(original_text: "feature", translated_text: "фишка")
    expect(card.check_translation("future")).to be false
  end

  it "shift date before saving" do
    card = Card.new
    expect(card.shift_date).to eq Date.today + 3.days
  end

  it "pass nonequal words" do
    card = Card.create(original_text: "Fall", translated_text: "Осень")
    expect(card.errors.any?).to be false
  end

  it "don't pass equal words" do
    card = Card.create(original_text: "Fall", translated_text: "Fall")
    expect(card.errors.any?).to be true
  end

  it "change cards number after success reviewing" do
    succ_card = Card.pending.first
    expect{succ_card.check_translation(succ_card.original_text)}.to change{Card.pending.count}.by(-1)
  end
end
