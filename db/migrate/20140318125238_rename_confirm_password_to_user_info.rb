class RenameConfirmPasswordToUserInfo < ActiveRecord::Migration
  def change
    rename_column :user_infos, :confirm_password, :password_confirmation
  end
end
