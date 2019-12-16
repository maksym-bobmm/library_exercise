class RatingController < ApplicationController
  def create
    return unless user_signed_in?

    book = Book.find(params['book_id'])
    return unless book

    already_liked =  book.users_likes.where(user_id: current_user.id).exists?
    book.users_likes.find_or_create_by(user_id: current_user.id).update_attribute(:score, params['score'])
    average_rating = book.rating.round(1)

    if already_liked
      render json: { tags: helpers.draw_rating(params['score'].to_i, book), average_rating: average_rating, already_liked: true }
    else
      render json: { tags: helpers.draw_rating(params['score'].to_i, book), average_rating: average_rating, already_liked: false }
    end
  end
end
