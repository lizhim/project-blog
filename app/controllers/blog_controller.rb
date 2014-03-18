class BlogController < ApplicationController
  def login
    flash[:error] = nil
    session[:account] = nil
  end

  def register

  end

  def validate_account_and_password
    @account = session[:account] = params[:user][:account]
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
    @account = params[:format]
  end

  def manager
    @account = params[:format]
    @current_account = User.where(:account => @account)
  end

  def detail
    @account = params[:account]
    @title = params[:title]
    @essay = User.find_by(account:@account, title:@title).essay
  end

  def edit
    @account = params[:account]
  end

  def destroy
    User.destroy params[:format]
  end

  def logout
    @account=params[:format]
    session[:account] = nil
    redirect_to '/blog/login'
  end
end
