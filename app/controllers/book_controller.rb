class BookController < ApplicationController
  def index
    @books = Book.order_by(name: :asc).page params[:page]
    @top_books = Book.order_by(rating: :desc).limit(5).to_a
  end

  def new; end

  def create
    if Book.create(book_params)
      redirect_to book_index_path
    else
      redirecT_to new_book_path
    end
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
    liked = @book.users_likes.where(user_id: current_user.id).exists?
    @rating_score = liked ? @book.users_likes.find_by(user_id: current_user.id).score : 0
    @likes_count = @book.users_likes.size
  end

  private

  def book_params
    params.permit(:name, :description, :author, :avatar)
  end
end
