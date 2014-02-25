class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.text :title
      t.text :essay

      t.timestamps
    end
  end
end
