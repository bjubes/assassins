module PlayersHelper
  def player_path(player)
    "/players/#{player.id}"
  end
end
