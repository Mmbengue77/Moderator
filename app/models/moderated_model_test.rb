# test/models/moderated_model_test.rb
require 'test_helper'

class ModeratedModelTest < ActiveSupport::TestCase
  test "should moderate content" do
    model = ModeratedModel.new(title: "Haineux content", description: "Lorem ipsum")
    
    # Mock de l'appel à l'API pour simuler le rejet
    Moderable.stub(:moderation_api_predict, { "accepted" => false }) do
      model.save
      assert_equal false, model.is_accepted
    end
  end

  test "should accept non-hateful content" do
    model = ModeratedModel.new(title: "Positive content", description: "Lorem ipsum")
    
    # Mock de l'appel à l'API pour simuler l'acceptation
    Moderable.stub(:moderation_api_predict, { "accepted" => true }) do
      model.save
      assert_equal true, model.is_accepted
    end
  end
end
