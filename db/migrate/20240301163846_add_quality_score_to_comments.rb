class AddQualityScoreToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :quality_score, :integer
  end
end
