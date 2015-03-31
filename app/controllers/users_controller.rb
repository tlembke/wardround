class UsersController < ApplicationController
    before_filter :check_format
    def check_format
      request.format = "html"
    end

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        redirect_to @user, :flash => { :success => 'User was successfully created.' }
      else
        render :action => 'new'
      end
    end

    def update
      @user = User.find(params[:id])
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if @user.update_attributes(params[:user])
        sign_in(@user, :bypass => true) if @user == current_user
        redirect_to @user, :flash => { :success => 'User was successfully updated.' }
      else
        render :action => 'edit'
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      request.format="mobile"
      redirect_to rounds_path, :flash => { :success => 'User was successfully deleted.' }
    end
    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :initials)
    end
 
end
