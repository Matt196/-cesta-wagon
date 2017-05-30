class UsersController < ApplicationController
  after_create :send_welcome_email


  def index
  end

  def new
  end

  def create
    @user = User.new(params[:user])
    binding.pry
    send_welcome_email(@user)
  end

  private
    def send_welcome_email(user)
      binding.pry
      UserMailer.welcome_email(user).deliver_now
    end


end



