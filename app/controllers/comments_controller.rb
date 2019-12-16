class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    render json: { created: false } and return if params['body']&.empty?

    book = Book.find(params['book_id'])
    return unless book

    if params['parent_comment_id']
      comment = book.comments.find(params['parent_comment_id']).comments.new(nested_comments_params)
    else
      comment = book.comments.new(comments_params)
    end
    render json: { created: false } and return unless comment.save

    new_comment = helpers.render('comments/comment', comment: comment)
    render json: { new_comment: new_comment, created: true }
  end

  def update
    return unless params['body']
    comment = Comment.find(params['comment_id'])
    comment.update(body: params['body'])

    render json: { body: comment.body, update_date: comment.updated_at.to_formatted_s(:short) }
  end

  def destroy
    return unless params['id']

    comment = Comment.find(params['id'])
    return unless comment

    comment.destroy
  end

  private

  def comments_params
    params.permit(:body, :user_id)
  end

  def nested_comments_params
    params.permit(:body, :user_id, :book_id)
  end
end
