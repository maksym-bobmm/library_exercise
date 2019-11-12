module BooksHelper
  def receive_book_state(book)
    book.state ? 'Out' : 'In'
  end

  def filled_rating_tags(like_score, book)
    link_to raw('<i class="fas fa-star fa-2x"></i>'), rating_index_path(score: like_score, book_id: book.id),
            method: :post, class: 'rating_link', remote: true
  end

  def empty_rating_tags(like_score, book)
    link_to raw('<i class="far fa-star fa-2x"></i>'), rating_index_path(score: like_score, book_id: book.id),
            method: :post, class: 'rating_link', remote: true
  end

  def draw_rating(like_score, book)
    result = ActiveSupport::SafeBuffer.new
    (1..5).each_with_index do |number, index|
      if index < like_score
        result << filled_rating_tags(number, book)
      else
        result << empty_rating_tags(number, book)
      end
    end
    result
  end
end
