class BasketLineMailer < ApplicationMailer
default from: 'notifications@example.com'

  def send_basket_email(producer, basket, user)
    @producer = producer
    @basket = basket
    @user = user
    mail(to: @producer.user.email, subject: 'Nouvelle pré-commande reçue via Cesta')
  end
end
