class TranslationVerificator
  def initialize(card, user_translation, response_time)
    @response_time = response_time
    @user_translation = user_translation
    @card = card
  end

  def result
    { assession_mark: assess_quality,
      calculated_number_of_reviews: calculate_number_of_reviews,
      calculated_review_date: calculate_review_date,
      calculated_e_factor: calculate_e_factor,
      calculated_interval: calculate_interval }
  end

  def calculate_number_of_reviews
    case assess_quality
    when 3, 4, 5 then @card.number_of_reviews += 1
    else @card.number_of_reviews = 0
    end
  end

  def assess_quality
    QualityAssessor.new(@response_time, @user_translation, @card).result
  end

  def calculate_review_date
    case @card.number_of_reviews
    when 0 then DateTime.now
    when 1 then DateTime.now + 1.days
    when 2 then DateTime.now + 6.days
    else
      DateTime.now + (@card.interval * @card.e_factor).round.days
    end
  end

  def calculate_e_factor
    x = @card.e_factor + (0.1 - (5 - assess_quality)*(0.08 + (5 - assess_quality) * 0.02))
    [x, 1.3].max
  end

  def calculate_interval
      (calculate_review_date.to_date - DateTime.now.to_date).to_i
  end

end
