module Moderable
  extend ActiveSupport::Concern

  included do
    before_save :moderate_attributes
    attribute :is_accepted, :boolean, default: true
    attribute :quality_score, :integer, default: 0
  end

  class_methods do
    def moderates(*attributes)
      @moderated_attributes = attributes
    end

    def moderated_attributes
      @moderated_attributes
    end
  end

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
