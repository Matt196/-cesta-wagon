class UsersController < ApplicationController

  # after_create :set_basket

  def index
  end

  def new
  end

  def create
    @user = User.new(params[:user])
    send_welcome_email(@user)
  end

  private
    def send_welcome_email(user)
      UserMailer.welcome_email(user).deliver_now
    end


end



