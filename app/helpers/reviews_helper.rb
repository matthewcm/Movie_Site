module ReviewsHelper
    def format_review_date(review)
    review.created_at.to_s(:short)
  end
  def format_review_title(review)
    if review.title == nil
      review.title ="n/a"
    end
    truncate(review.title, length: 10)
  end
  def format_review_body(review)
    if review.body == nil
      review.body = "n/a"
    end
    truncate(review.body, length: 20 )
  end
end
