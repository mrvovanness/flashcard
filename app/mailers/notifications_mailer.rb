class NotificationsMailer < ActionMailer::Base
  def pending_cards(user)
    @user = user
    @url = ENV['URL_DEFAULT']
    mail(to: @user.email, subject: "Пришло время проверить карточки")
  end
end
