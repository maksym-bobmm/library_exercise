class BookController < ApplicationController
  def index
    @books = Book.all
    @top_books = @books.sort_by { |book| book.rating }.reverse.first(5)
  end

  def new; end

  def create
    Book.create(book_params)
    redirect_to book_index_path
  end

  def destroy
    Book.find(params['id']).delete
    redirect_to book_index_path
  end

  def destroy_multiple
    return unless params['books_ids'].present?

    ids = params['books_ids']
    ids.each do |id|
      Book.find(id).destroy
    end
    redirect_to book_index_path
  end

  def show
    @book = Book.find(params['id'])
  end

  private

  def book_params
    params.permit(:name, :description, :author)
  end

end
