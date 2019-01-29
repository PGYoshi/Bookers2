class BooksController < ApplicationController

  before_action :authenticate_user!

  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

    def ensure_correct_user
      @book = Book.find(params[:id])
      if @book.user.id != current_user.id
        redirect_to books_path
      end
    end


	def new
		@book = Book.new
	end

	def create
		 @book = Book.new(book_params)
		 @book.user_id = current_user.id
    	 if @book.save
    	 flash[:notice] = "Book was successfully saved"
    	 redirect_to book_path(@book.id)
    	else
    	 	flash[:notice] = "error"

    		@books = Book.all
    		@book = Book.new
			@user = User.find(current_user.id)
    		render 'index'
    	end
	end

	def index
		@books = Book.all
		@book = Book.new
		@user = User.find(current_user.id)

	end

	def  show
		@book = Book.new
		@book_show = Book.find(params[:id])
		@user = @book_show.user
	end

	def edit
		@book = Book.find(params[:id])
	end

	def update
		@book = Book.find(params[:id])
		if @book.update(book_params)
		flash[:notice] = "Book was successfully edited"
		redirect_to book_path(@book.id)
		else
	    render 'edit'
	    end
	end

	def destroy
		@book = Book.find(params[:id])
		@book.destroy
		redirect_to books_path
	end


	private

	def book_params
		params.require(:book).permit(:title, :opinion)
	end
end
