class CreateCommentTable < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body 
      t.timestamps
      t.booleen :is
    end
  end
end
