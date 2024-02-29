class ModeratedModel < ApplicationRecord
    include Moderable
    moderates :your_attribute_name # Remplacez :your_attribute_name par le nom de votre attribut
  end