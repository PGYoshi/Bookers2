class UsersController < ApplicationController

before_action :authenticate_user!

before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user
    if params[:id].to_i != current_user.id
        redirect_to user_path(current_user.id)
    end
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
  end

  def index
  	@users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "User's update was successfully edited"
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :image)
  end

end

