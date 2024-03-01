class Comment < ApplicationRecord
  include Moderable
  moderates :body

  # ... d'autres associations et validations ...

  before_save :moderate_attributes

  # ... d'autres méthodes et callbacks ...

  def moderate_attributes
    self.class.moderated_attributes.each do |attribute|
      content = send(attribute)
      next if content.blank?

      moderation_result = ModerationService.evaluate(content)
      self.is_accepted = moderation_result[:is_accepted]
      self.quality_score = moderation_result[:score]

      if self.quality_score < 3
        # Marquer pour révision manuelle, par exemple
        self.needs_review = true
      end
    end
  end
end
