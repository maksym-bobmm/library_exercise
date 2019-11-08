class BookController < ApplicationController
  def index
    @books = Book.order_by(name: :asc).page params[:page]
    @top_books = Book.order_by(rating: :desc).limit(5).to_a
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
    byebug
    @book = Book.find(params['id'])
    @liked = current_user.liked_books.where(book_id: @book.id).exists?
    @rating_score = current_user.liked_books.find_by(book_id: @book.id).score if @liked
  end

  private

  def book_params
    params.permit(:name, :description, :author)
  end

end
