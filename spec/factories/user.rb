FactoryGirl.define do
  factory :user do
    email "ex@mail.com"
    password "1111"
    password_confirmation { password }
    id 1
    current_deck_id 1
  end
end
