class BooksController < ApplicationController
	before_action :authenticate_user!,except: :top
	before_action :correct_book, only: [:edit, :update]

	def new
	end

	def top
	end

	def create
		@new_book = Book.new(book_params)
	    @new_book.user_id = current_user.id
	    if  @new_book.save
	    	flash[:notice] = "You have creatad book successfully."
	    	redirect_to book_path(@new_book)
		else
			@books = Book.all
			@user = current_user
			flash[:notice] = "error"
			render :index
		end
	end

	def index
		@new_book = Book.new
		@books = Book.all
		@user = current_user
	end

	def show
		@book = Book.find(params[:id])
		@user = @book.user
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if  @book.update(book_params)
			flash[:notice] = "Book was successfully created."
			redirect_to book_path(@book)
	    else
	    	flash[:notice] = "error"
	    	render :edit
	    end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end

	private
    def book_params
        params.require(:book).permit(:title, :body)
    end

    def correct_book
    	book = Book.find(params[:id])
    if current_user != book.user
      redirect_to books_path
    end
    end
end
