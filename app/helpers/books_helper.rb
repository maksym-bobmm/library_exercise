module BooksHelper
  def receive_book_state(book)
    book.state ? 'Out' : 'In'
  end

  def filled_rating_tags(star_serial_number)
    link_to image_tag('star_filled.png', alt: 'rating', id: "star_filled_#{star_serial_number}"),
            rating_index_path, method: :post
  end

  def empty_rating_tags(star_serial_number, book)
    byebug

    link_to image_tag('star_empty.png', alt: 'rating', id: "star_empty_#{star_serial_number}"),
            rating_index_path(star_serial_number, book_id: book.id), method: :post
  end

  def draw_rating_with(num = 5)
    result = ActiveSupport::SafeBuffer.new
    (1..num).each do |index|
      result << yield(index)
    end
    result
  end
end
