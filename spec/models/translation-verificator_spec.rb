require 'rails_helper'

describe "TranslationVerificator" do
  let! (:card) { create(:card) }
    before (:each) do
    user_translation = "Mantle"
    response_time = 10
    @results_hash = TranslationVerificator.new(card, user_translation, response_time).result
    end

  it "number of reviws changes" do
    expect(@results_hash[:number_of_reviews]).to be 1
  end

  it "review date changes" do
    expect(@results_hash[:review_date].to_date).to eq Date.today + 1.day
  end

  it "e-factor changes" do
    expect(@results_hash[:e_factor]).to be 2.5 + (0.1 - (5 - 5) * (0.08 + (5 - 5) * 0.02))
  end
  it "interval changes" do
    expect(@results_hash[:interval]).to be 1
  end
end
