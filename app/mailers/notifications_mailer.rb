class NotificationsMailer < ActionMailer::Base
  default from: "notification@flashcard-app-sample.herokuapp.com"
  def pending_cards(user)
    @user = user
    @url = "http://flashcard-app-sample.herokuapp.com/"
    mail(to: @user.email, subject: "Пришло время проверить карточки")
  end
end
