class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def create
    return if params['body']&.empty?
    book = Book.find(params['book_id'])
    if params['parent_comment_id']
      comment = book.comments.find(params['parent_comment_id']).comments.new(nested_comments_params)
    else
      comment = book.comments.new(comments_params)
    end
    comment.save
    new_comment = helpers.render('comments/comment', comment: comment)
    render json: new_comment
  end

  def update
    return unless params['body']
    comment = Comment.find(params['comment_id'])
    comment.update(body: params['body'])
    book = Book.find(params['id'])
    if request.xhr?
      render json: { body: comment.body, update_date: comment.updated_at.to_formatted_s(:short) }
    else
      redirect_to book_path(book)
    end
  end

  def destroy
    return unless params['id']

    comment = Comment.find(params['id'])
    comment.destroy
  end

  private

  def comments_params
    params.permit(:body, :user_id)
  end

  def nested_comments_params
    comments_params.merge(book_id: params['book_id'])
  end
end
