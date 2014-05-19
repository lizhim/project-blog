class UserInfo < ActiveRecord::Base
  validates :account, presence: {message:'(用户名)不能为空'}, uniqueness: { case_sensitive: false }
  validates :password, presence: {message:'(密码)不能为空'}, confirmation: true
  validates :password_confirmation, presence: {message:'(密码输入不一致)'}
  #validates :mailbox, presence: {message:'邮箱不能为空'}
  validates :question, presence: {message:'(问题)不能为空'}
  validates :answer, presence: {message:'(答案)不能为空'}

end
