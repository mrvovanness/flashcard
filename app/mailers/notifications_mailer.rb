class NotificationsMailer < ActionMailer::Base
  def pending_cards(user)
    @user = user
    @url = root_url
    mail(to: @user.email, subject: "Пришло время проверить карточки")
  end
end
