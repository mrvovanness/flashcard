class QualityAssessor
  def initialize(response_time, user_translation, card)
    @response_time = response_time
    @user_translation = user_translation
    @card = card
  end

  def result
    typos_count = DamerauLevenshtein.distance(
      @card.original_text.mb_chars.downcase.strip,
      @user_translation.mb_chars.downcase.strip, 0)
    case typos_count
    when 1,2 then 2 
    when 0 then [5, response_time_assessor].min
    else [1, response_time_assessor_for_fail].min
    end
  end

  private

  def response_time_assessor
    case @response_time
    when 0..20 then 5
    when 21..30 then 4
    else 3
    end
  end

  def response_time_assessor_for_fail
    case @response_time
    when 00..40 then 1
    else 0
    end
  end
end
