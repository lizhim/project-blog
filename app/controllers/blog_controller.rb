class BlogController < ApplicationController
  def login
    flash[:error] = nil
  end

  def validate_account_and_password
    @account = params[:user][:account]
    @password = params[:user][:password]
    user=User.find_by_account_and_password(@account, @password)
    if user.nil?
      flash[:error] = '用户名或密码错误'
      render '/blog/login'
    else
      redirect_to blog_manager_path(@account)
    end
  end

  def post

  end

  def manager
    @account = params[:format]

  end
end
