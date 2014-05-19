class Article < ActiveRecord::Base
  def self.save_blog_of_user(account_id, blog_info)
    create(:user_id => account_id, :title => blog_info[:title], :essay => blog_info[:essay], :sort => blog_info[:sort],
           :status => 'script')
  end

  def self.fetch_count_of_script(account_id, status)
    where(:user_id => account_id, :status => status).count
  end

  def self.save_publish_blog_of_user(account_id, blog_info)
    new_blog = find_by(user_id: account_id, title:blog_info[:title], status: 'publish')
    if new_blog.blank?
      create(:user_id => account_id, :title => blog_info[:title], :essay => blog_info[:essay], :sort => blog_info[:sort],
             :status => 'publish')
    end
  end
end
