class UsersController < ApplicationController
  def index
    @users = User.find(:all)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      add_lockdown_session_values
      redirect_to account_url
    else
      render :action => :new
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def destroy
    if current_user_is_admin?
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = "User #{user.login} deleted!"
    end

    redirect_to root_path
  end
end
