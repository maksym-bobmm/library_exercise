class CommentsController < ApplicationController
  def new
    byebug
  end

  def create
    byebug
    book = Book.find(params['book_id'])
    book.comments.create!(comments_params)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    # @comments = Comment.all
  end

  private

  def comments_params
    # params['user_id'] = current_user.id if params['user_id'].blank?
    params.permit(:body, :user_id)
  end
end
