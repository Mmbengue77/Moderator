# app/models/concerns/moderable.rb
module Moderable
  extend ActiveSupport::Concern

  included do
    before_save :moderate_attributes
    attribute :is_accepted, :boolean, default: true
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

      response = ModerationService.check(content)
      self.is_accepted = response[:is_accepted]

      unless self.is_accepted
        # Si le contenu est rejeté, vous pouvez choisir de ne pas sauvegarder le commentaire,
        # de le marquer pour révision, ou de prendre une autre action appropriée.
        # Par exemple, annuler la sauvegarde :
        throw :abort
      end
    end
  end
end
