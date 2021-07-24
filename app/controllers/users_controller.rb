class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end 
  
  def edit 
    @user = User.find(params[:id])
     unless @user.id == current_user.id
      redirect_to user_path(current_user)
     end
  end 
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
    render :edit
    end 
  end 
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end 
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end
  
end
