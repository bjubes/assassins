class StaticPagesController < ApplicationController
  def home
    if !user_signed_in?
      render "landing"
    end
  end
end
