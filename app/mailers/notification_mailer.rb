class NotificationMailer < ApplicationMailer
  def book_completed(user, book)
    @user = user
    @book = book
    mail(to: @user.email, subject: "Congratulations on completing '#{@book.title}'!")
  end
end