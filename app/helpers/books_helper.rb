module BooksHelper
  def receive_book_state(book)
    book.state ? 'Out' : 'In'
  end

  def filled_rating_tags(index, book)
    link_to image_tag('star_filled.png', alt: 'rating', id: "star_filled_#{index}"),
            rating_index_path(score: index, book_id: book.id), method: :post, remote: true
  end

  def empty_rating_tags(index, book)
    byebug
    link_to image_tag('star_empty.png', alt: 'rating', id: "star_empty_#{index}"),
            rating_index_path(score: index, book_id: book.id), method: :post, remote: true
  end

  def draw_rating(num = 5, book)
    result = ActiveSupport::SafeBuffer.new
    byebug
    (1..num||5).each do |index|
      result << yield(index, book)
    end
    result
  end
end
