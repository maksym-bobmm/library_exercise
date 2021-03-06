# frozen_string_literal: true

# book controller
class BooksController < ApplicationController
  def index
    @books = Book.order_by(name: :asc).page params[:page]
    @top_books = Book.all.to_a.sort_by(&:rating).last(5).reverse
  end

  def new; end

  def create
    return unless user_signed_in?

    book = Book.create(book_params)
    if book.save
      redirect_to books_path
    else
      redirect_to new_book_path
    end
  end

  def destroy
    return unless user_signed_in?

    book = Book.find(params['id'])
    return unless book

    book.delete

    render json: { book_id: params['id'] }
  end

  def destroy_multiple
    return unless params['books_ids'].present? && user_signed_in?

    ids = params['books_ids']
    ids.each do |id|
      book = Book.find(id)
      continue unless book

      book.delete
    end
    redirect_to books_path
  end

  def show
    @book = Book.includes(:histories).find(params['id'])
    redirect_to books_path and return unless @book

    liked = @book.users_likes.where(user_id: current_user&.id).exists?
    @rating_score = liked ? @book.users_likes.find_by(user_id: current_user&.id).score : 0
    @likes_count = @book.users_likes.size
    @parent_comments = @book.comments.parent_comments
  end

  def take
    return unless user_signed_in?

    book = Book.find(params['book_id'])
    return unless book
    return if book.state == false

    book.update_attributes(state: false)
    book.histories.create(user_id: current_user.id, take_date: Time.now)

    render json: { button: helpers.draw_take_button(book) }
  end

  def return
    return unless user_signed_in?

    book = Book.find(params['book_id'])
    return unless book
    return if book.state == true

    book.update_attributes(state: true)
    book.histories.all.last.update_attributes(return_date: Time.now) if book.histories.any?

    render json: { button: helpers.draw_take_button(book) }
  end

  def letsencrypt
    render text: "#{params[:id]}.#{ENV['LETS_ENCRYPT_KEY']}"
  end

  private

  def book_params
    params.permit(:name, :description, :author, :avatar)
  end
end
