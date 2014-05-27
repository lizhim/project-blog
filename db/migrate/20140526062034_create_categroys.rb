class CreateCategroys < ActiveRecord::Migration
  def change
    create_table :categroys do |t|
      t.integer :user_id
      t.integer :article_id
      t.string :sort

      t.timestamps
    end
  end
end
