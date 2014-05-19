class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :account
      t.string :password
      t.string :confirm_password
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
