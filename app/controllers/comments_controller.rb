class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def new
    byebug
  end

  def create
    book = Book.find(params['book_id'])
    if params['parent_comment_id']
      comment = book.comments.find(params['parent_comment_id']).comments.new(nested_comments_params)
    else
      comment = book.comments.new(comments_params)
    end
    comment.save
    byebug
    respond_to {|f| f.json {render comment}}
    # respond_to do |format|
    #   # byebug
    #   format.json { render html: helpers.render('comments/comment', comment: comment) }
    # end
    # render json: { parent_comment_id: helpers.render('comments/comment', comment: comment) }
    # redirect_to book

  end

  def edit
  end

  def update
    return unless params['body']
    comment = Comment.find(params['comment_id'])
    comment.update(body: params['body'])
    book = Book.find(params['id'])

    if request.xhr?
      # byebug
      render json: { body: comment.body }
    else
      redirect_to book_path(book)
    end
  end

  def destroy
  end

  def show
    # @comments = Comment.all
  end

  private

  def comments_params
    params.permit(:body, :user_id)
  end

  def nested_comments_params
    comments_params.merge(book_id: params['book_id'])
  end
end
