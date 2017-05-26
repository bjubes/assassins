class KillsController < ApplicationController
  def index
    #todo, show unconfirmed kills based on whether they are your kills/ you are an admin
    @kills = Kill.confirmed_kills
  end
end
