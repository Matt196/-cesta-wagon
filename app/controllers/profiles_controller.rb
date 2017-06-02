class ProfilesController < ApplicationController
  skip_after_action :verify_authorized, only: [:show]

   skip_after_action :verify_authorized, only: [:show]

  def show
  end
end
