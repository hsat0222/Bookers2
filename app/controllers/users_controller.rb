class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

	def index
		#@book = Book.find(params[:id])
		#@user = @book.user
		@users = User.all
		@user = current_user
	end

	def show
		# @book = Book.find(params[:id])
		# @user = @book.user
		# @new_book = Book.new
		# @finduser = User.find(params[:id])

		@books = Book.where(user_id: params[:id])
		@finduser = User.find(params[:id])
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		  if @user.update(user_params)
		  	 flash[:notice] = "You have updated user successfully."
			 redirect_to user_path(@user)
		  else
		  	 flash[:notice] = "error"
		   	 render :edit
		  end
	end

	private
	def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
	end

	def correct_user
	    user = User.find(params[:id])
	    if current_user != user
	      redirect_to user_path(current_user)
    	end
	end

end
