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

  def draw_take_button(book)
    if book.state
      button_name = 'Take'
      css_class = 'bg-success'
      disabled = false
      action = 'take'
    else
      taked_user_id = book.histories.any? ? book.histories.last.user_id.to_s : current_user.id.to_s
      button_name = current_user.id.to_s == taked_user_id ? 'Return' : 'Already taken'
      disabled = current_user.id.to_s == taked_user_id ? false : true
      css_class = 'bg-warning'
      action = 'return'
    end
    button_to button_name, { action: action, book_id: book.id }, class: css_class, disabled: disabled, remote: true
  end
end
