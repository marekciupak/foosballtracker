module PlayersHelper
  def avatar_url(player, size=80)
    gravatar_id = Digest::MD5::hexdigest(player.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?d=monsterid&s=#{size}"
  end
end
