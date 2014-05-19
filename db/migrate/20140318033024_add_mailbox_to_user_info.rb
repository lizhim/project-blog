class AddMailboxToUserInfo < ActiveRecord::Migration
  def change
    add_column :user_infos, :mailbox, :string
  end
end
