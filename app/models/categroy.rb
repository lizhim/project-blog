class Categroy < ActiveRecord::Base

  def self.save_sort_of_user(account_id, article, sort)
    find_or_create_by(:user_id => account_id, :article_id => article, :sort => sort)
  end

end
