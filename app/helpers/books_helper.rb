module BooksHelper
  def receive_book_state(book)
    book.state ? 'In' : 'Out'
  end

  def filled_rating_tags(like_score, book)
    link_to content_tag(:i, nil, class: 'fas fa-star star-image'), rating_index_path(score: like_score, book_id: book.id),
            method: :post, class: 'rating_link', remote: true
  end

  def empty_rating_tags(like_score, book)
    link_to raw('<i class="far fa-star star-image"></i>'), rating_index_path(score: like_score, book_id: book.id),
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
    css_class = 'btn-lg'
    if book.state || !user_signed_in?
      button_name = 'Take'
      css_class << ' bg-success'
      disabled = !user_signed_in?
      action = take_book_index_path(book_id: book.id)
    else
      taked_user_id = book.histories.any? ? book.histories.last.user_id.to_s : current_user.id.to_s
      button_name = current_user.id.to_s == taked_user_id ? 'Return' : 'Already taken'
      disabled = current_user.id.to_s == taked_user_id ? false : true
      css_class << ' bg-warning'
      action = return_book_index_path(book_id: book.id)
    end
    button_to button_name, action, class: css_class, disabled: disabled, remote: true
  end

  def receive_book_taker(book)
    user_id = book.histories.last.user_id
    user = User.find(user_id)
    "#{user.email}"
  end
end
