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
        if response[:rejected]
          self.is_accepted = false
          break
        end
      end
    end
  end