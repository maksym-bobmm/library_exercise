class RatingController < ApplicationController
  def create
    return unless user_signed_in?
    return if current_user.liked_books.where(id: params[:book_id]).exists?

    book = Book.find(params['book_id'])
    current_user.liked_books.find_or_create_by(book_id: book.id).update_attribute(:score, params['score'])

    if request.xhr?
      render json: { tags: helpers.draw_rating(params['score'].to_i, book) }
    else
      redirect_to book_path(book)
    end
  end

  private
  def liked_books_params
    params.permit(:book_id, :score)
  end
end
