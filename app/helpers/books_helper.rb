module BooksHelper
  def format_book_title(book)
    book.title.upcase
  end

  def status_icon_class(status)
    case status
    when 'reading'
      'icon-book-open'
    when 'completed'
      'icon-check'
    when 'want_to_read'
      'icon-bookmark'
    else
      'icon-book'
    end
  end

  def rating_stars(rating)
    '★' * rating + '☆' * (5 - rating)
  end

  def display_date(date)
    date.strftime('%m/%d/%Y')
  end

  def reading_time_estimate(pages)
    minutes = pages * 2
    "#{minutes} minutes"
  end

  def truncate_description(text, length = 150)
    truncate(text, length: length)
  end
end