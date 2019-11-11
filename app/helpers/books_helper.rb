module BooksHelper
  def receive_book_state(book)
    book.state ? 'Out' : 'In'
  end

  def filled_rating_tags(index, book)
    link_to image_tag('star_filled.png', alt: 'rating', id: "star_filled_#{index}"),
            rating_index_path(score: index, book_id: book.id), method: :post, class: 'rating_link', remote: true
  end

  def empty_rating_tags(index, book)
    link_to image_tag('star_empty.png', alt: 'rating', id: "star_empty_#{index}"),
            rating_index_path(score: index, book_id: book.id), method: :post, class: 'rating_link', remote: true
  end

  def draw_rating(num, book)
    result = ActiveSupport::SafeBuffer.new
    (1..5).each_with_index do |number, index|
      if index < num
        result << filled_rating_tags(number, book)
      else
        result << empty_rating_tags(number, book)
      end
    end
    result
  end
end
