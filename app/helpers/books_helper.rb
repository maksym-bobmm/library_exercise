module BooksHelper
  def receive_book_state(book)
    book.state ? 'Out' : 'In'
  end
end
