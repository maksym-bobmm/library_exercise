module CommentsHelper
  def draw_comments
    result = ActiveSupport::SafeBuffer.new
    @book.comments.each do |comment|
      result.concat content_tag :div, class: ('nested_comment' if comment.has_parent?) do
        content_tag(:p, current_user.username? ? current_user.email : current_user.username)
        content_tag(:span, comment.update_date)
        content_tag(:p, comment.body)
      end
    end
    result
  end
end
