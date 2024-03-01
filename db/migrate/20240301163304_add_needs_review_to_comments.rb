class AddNeedsReviewToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :needs_review, :boolean
  end
end

class AddQualityScoreToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :quality_score, :integer
  end
end


class AddNeedsReviewToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :needs_review, :boolean
  end
end
