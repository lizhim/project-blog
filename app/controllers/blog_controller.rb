class BlogController < ApplicationController
  def login
    flash[:error] = nil
    session[:account] = nil
  end

  def validate_account_and_password
    @account = session[:account] = params[:user_info][:account]
    @password = params[:user_info][:password]
    user=UserInfo.find_by(:account => @account, :password => @password)
    if user.nil?
      flash[:error] = '用户名或密码错误'
      render '/blog/login'
    else
      judge_manager_or_user(user)
    end
  end

  def judge_manager_or_user(user)
    if user[:admin] == true
      session[:account] = user[:account]
      redirect_to "/blog/manage_user"
    else
      session[:account] = user[:account]
      redirect_to "/blog/manager"
    end
  end

  def register
    flash[:notice] = nil
    @account=UserInfo.new
  end

  def judge_password_repeat
    flash[:notice] = nil
    @user_account = params[:user_info][:account]
    @password = params[:user_info][:password]
    @password_confirmation = params[:user_info][:password_confirmation]
    @question = params[:user_info][:question]
    @answer = params[:user_info][:answer]
    account = UserInfo.find_by(account:@user_account)
    if @user_account.blank? || @password.blank? || @password_confirmation.blank? || @question.blank? || @answer.blank?
      flash[:notice] = '请将信息填写完整'
      render '/blog/register'
    elsif account.present?
      flash[:notice] = '此用户名已注册'
      render '/blog/register'
    elsif @password_confirmation != @password
      flash[:notice] = '两次密码输入不一致'
      render '/blog/register'
    else
      @user = UserInfo.new(user_params)
      @user.save
      redirect_to '/blog/login'
    end
  end


  def post
    @account = session[:account]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').order('created_at DESC')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
  end

  def manager
    @account = session[:account]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').order('created_at DESC')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
  end

  def edit_publish
    @account = session[:account]
    @article_id = params[:account_id]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').order('created_at DESC')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
    @edited_article = Article.find_by(:id => params['account_id'])
  end

  def edit_publish_save
    account = params[:account]
    account_id = UserInfo.find_by(account: account).id
    Article.find_by(id: params[:article_id]).update_attributes(title: params[:title], sort: params[:sort], essay: params[:essay])
    render :text => 'ok', :status => 200
  end

  def script
    @account = session[:account]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').order('created_at DESC')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script').order('created_at DESC')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
  end

  def category_manage
    @account = session[:account]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish')
    @category = @all_blog_of_account.group('sort').count
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
  end

  def detail
    @account = session[:account]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').reverse
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
    @title = params[:title]
    @update_at = Article.find_by(:user_id => account.id, :title => @title).updated_at.to_date
    @essay = Article.find_by(user_id:account.id, title:@title).essay
  end

  def edit
    @account = params[:account]
  end

  def destroy_script
    @account = session[:account]
    Article.find_by(id: params['account_id']).update_attributes(status: 'recycle')
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
    render '/blog/script'
  end

  def destroy_publish
    @account = session[:account]
    Article.find_by(id: params['account_id']).update_attributes(status: 'recycle')
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
    render :text => 'ok', :status => 200
  end

  def logout
    @account=params[:format]
    session[:account] = nil
    redirect_to '/blog/login'
  end

  def manage_user
    @account = session[:account]
    @user = UserInfo.paginate(page: params[:page],per_page: 10).where(:admin=>false)
  end

  def destroy_user
    UserInfo.destroy params[:format]
    redirect_to '/blog/manage_user'
  end

  def save_script
    account = params[:account]
    account_id = UserInfo.find_by(account: account).id
    if params[:title]!= ''
      Article.save_blog_of_user(account_id, params)
      script_count = Article.fetch_count_of_script(account_id, 'script')
      render :text=> script_count
    end
  end

  def publish
    account = params[:account]
    account_id = UserInfo.find_by(account: account).id
    if params[:title]!= ''
      Article.save_publish_blog_of_user(account_id, params)
      script_count = Article.fetch_count_of_script(account_id, 'publish')
      render :text=> script_count
    end
  end

  def add_user
    flash[:notice] = nil
    @account = session[:account]
  end

  def judge_user_password_repeat
    flash[:notice] = nil
    @account = session[:account]
    @user_account = params[:user_info][:account]
    @password = params[:user_info][:password]
    @password_confirmation = params[:user_info][:password_confirmation]
    @question = params[:user_info][:question]
    @answer = params[:user_info][:answer]
    account = UserInfo.find_by(account:@user_account)
    if @user_account.blank? || @password.blank? || @password_confirmation.blank? || @question.blank? || @answer.blank?
      flash[:notice] = '请将信息填写完整'
      render '/blog/add_user'
    elsif account.present?
      flash[:notice] = '此用户名已注册'
      render '/blog/add_user'
    elsif @password_confirmation != @password
      flash[:notice] = '两次密码输入不一致'
      render '/blog/add_user'
    else
      @user=UserInfo.new(user_params)
      @user.save
      redirect_to '/blog/manage_user'
    end
  end

  def edit_script
    @account = session[:account]
    @article_id = params[:account_id]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').reverse
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
    @edited_article = Article.find_by(:id => params['account_id'])
  end

  def edit_script_save
    account = params[:account]
    account_id = UserInfo.find_by(account: account).id
    Article.find_by(id: params[:article_id]).update_attributes(title: params[:title], sort: params[:sort], essay: params[:essay])
    render :text => 'ok', :status => 200
  end

  def publish_script
    account = params[:account]
    account_id = UserInfo.find_by(account: account).id
    Article.find_by(id: params[:article_id]).update_attributes(title: params[:title], sort: params[:sort], essay: params[:essay], status: 'publish', created_at: Time.now)
    render :text => 'ok', :status => 200
  end

  def recycle
    @account = session[:account]
    account = UserInfo.find_by(:account => @account)
    @all_blog_of_account = Article.where(:user_id => account[:id], :status => 'publish').order('created_at DESC')
    @script_essay_of_account = Article.where(:user_id => account[:id], :status => 'script')
    @recycle_essay = Article.where(:user_id => account[:id], :status => 'recycle').order('created_at DESC')
    @recycle_essay_count = @recycle_essay.count
    @all_blog_count = @all_blog_of_account.count
    @script_essay_count =  @script_essay_of_account.count
  end

  private
  def user_params
    params.require(:user_info).permit(:account, :password, :password_confirmation, :question, :answer)
  end
end
