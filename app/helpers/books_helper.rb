module BooksHelper
  def receive_book_state(book)
    book.state ? 'Out' : 'In'
  end
  def generate_filled_rating_tags(star_serial_number)
    link_to image_tag('star_filled.png', alt: 'rating', id: "star_filled_#{star_serial_number}"),

  end
  def generate_empty_rating_tags(star_serial_number)
    link_to image_tag('star_empty.png', alt: 'rating', id: "star_empty_#{star_serial_number}"),

  end

end
