class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @rel = @user.follower.find_by(follower: current_user)
  end
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @rel = @user.follower.find_by(follower_id: current_user.id)
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
  
  def following
    @user = User.find(params[:id])
    render :show_follow
  end 
  
  def followers
    @user = User.find(params[:id])

    render :show_follower
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
