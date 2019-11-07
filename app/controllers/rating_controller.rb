class RatingController < ApplicationController
  def create
    return unless user_signed_in?
    return if current_user.liked_books.where(id: params[:book_id]).exists?

    byebug
    current_user.liked_books.create(liked_books_params)

    render json: { tags: helpers.draw_rating_with { |number| helpers.empty_rating_tags(number) } }
  end

  private

  def liked_books_params
    params.permit(:book_id, :score)
  end
end
