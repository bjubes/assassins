class StaticPagesController < ApplicationController
  def home
    if !user_signed_in?
      render "landing"
    elsif !current_user.game
      render "join_game"
    elsif !current_user.team
      render "join_team"
    end
  end
end
