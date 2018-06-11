class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
  end
  
  def new
    @book = Book.new
  end

  def create
    @book = current_user.build_book(book_params)
    if @book.save
      flash[:success] = 'Book Registeration Successful'
      redirect_to root_url
    else
      flash.now[:danger] = 'Book Registration Failed'
      render :new
    end
  end

  def edit
    @book = current_user.book
  end

  def update
    @book = current_user.book
    if @book.update(book_params)
      flash[:success] = 'Book Update Successful'
      redirect_to root_url
    else
      flash.now[:danger] = 'Book Update Failed'
      render :edit
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:image, :title, :author, :language, :page, :description)
  end
end