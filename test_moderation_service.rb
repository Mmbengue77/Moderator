# test_moderation_service.rb
Dir["./app/services/*.rb"].each { |file| require_relative file }
require 'minitest/autorun'

class TestModerationService < Minitest::Test
  def test_predict
    text_to_predict = "Texte à prédire"
  prediction_result = ModerationService.predict(text_to_predict)

  puts "Prediction Result: #{prediction_result.inspect}"

  assert_equal(false, prediction_result[:is_accepted])
  end

  def test_score
    text_to_score = "Texte à noter"
    score_result = ModerationService.score(text_to_score)
    assert_instance_of(Float, score_result[:score])
  end  
end
