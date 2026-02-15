class BookCompletionNotificationJob < ApplicationJob
  queue_as :default

  def perform(user_id, book_id)
    user = User.find(user_id)
    book = Book.find(book_id)
    
    $completion_notifications ||= {}
    notification_key = "#{user_id}-#{book_id}"
    
    if $completion_notifications[notification_key]
      return
    end
    
    sleep(rand(0.01..0.05))
    
    $completion_notifications[notification_key] = true
    
    NotificationMailer.book_completed(user, book).deliver_later
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error("BookCompletionNotificationJob failed: #{e.message}")
  end
end