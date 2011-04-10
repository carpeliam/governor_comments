module GovernorCommentsHelper
  def comment_count(article)
    governor_authorized?(:edit, article) ?
      article.comments.size :
      article.comments.select{|comment| !comment.hidden? }.size
  end
end
