class RatingController < ApplicationController
  def create
    return unless user_signed_in?

    book = Book.find(params['book_id'])
    liked =  book.users_likes.where(user_id: current_user.id).exists?
    book.users_likes.find_or_create_by(user_id: current_user.id).update_attribute(:score, params['score'])
    average_rating = book.rating.round(1)

    if request.xhr?
      if liked
        render json: { tags: helpers.draw_rating(params['score'].to_i, book), average_rating: average_rating }
      else
        render json: { tags: helpers.draw_rating(params['score'].to_i, book), average_rating: average_rating, liked: true }
      end
    else
      redirect_to book_path(book)
    end
  end

  private
  def liked_books_params
    params.permit(:book_id, :score)
  end
end
