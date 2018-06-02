class BooksController < ApplicationController
  def search
    @mylocation = Mylocation.find_by(id: current_user.mylocation_id)
    @users = @mylocation.users
    @books = []
    @users.each do |user|
      if user.book.present?
        @books << user.book
      end
    end
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