FactoryGirl.define do

  factory :card do
    original_text "Mantle"
    translated_text "Мантия"

    after(:create) do |card|
      card.update_attribute(:review_date, Date.today - 1.day)
    end
  end
end
