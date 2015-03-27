require 'rails_helper'

describe Deck do
  let! (:deck) { create(:deck) }

  it "titleize before saving" do
    expect(deck.name).to eq("Magic")
  end
end
