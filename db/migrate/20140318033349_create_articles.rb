class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :essay
      t.string :sort
      t.string :status

      t.timestamps
    end
  end
end
