class Comment < ApplicationRecord
    include Moderable
    moderates :body
  end
  