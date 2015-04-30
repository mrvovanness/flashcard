require 'rails_helper'

describe "QualityAssessor" do
  before (:each) do
  end
  it "excellent example" do
    response_time = 10
    user_translation = "Mantle"
    original_text = "Mantle"
    data = QualityAssessor.new(response_time, user_translation, original_text)
    expect(data.result).to be 5
  end
  it "good example" do
    response_time = 21
    user_translation = "Mantle"
    original_text = "Mantle"
    data = QualityAssessor.new(response_time, user_translation, original_text)
    expect(data.result).to be 4
  end

  it "moderate example" do
    response_time = 31
    user_translation = "Mantle"
    original_text = "Mantle"
    data = QualityAssessor.new(response_time, user_translation, original_text)
    expect(data.result).to be 3
  end

  it "bad example" do
    response_time = 10
    user_translation = "Mantl"
    original_text = "Mantle"
    data = QualityAssessor.new(response_time, user_translation, original_text)
    expect(data.result).to be 2
  end

  it "harsh example" do
    response_time = 10
    user_translation = "wrong stuff"
    original_text = "Mantle"
    data = QualityAssessor.new(response_time, user_translation, original_text)
    expect(data.result).to be 1
  end

  it "the worst example" do
    response_time = 100
    user_translation = "wrong stuff"
    original_text = "Mantle"
    data = QualityAssessor.new(response_time, user_translation, original_text)
    expect(data.result).to be 0
  end
end
