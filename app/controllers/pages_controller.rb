class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :guidelines]

  def home
  end

  def guidelines
    @producer = Producer.new
  end
end
