module UsersHelper
  def render_user_screen_name(user)
    if user.screen_name.blank?
      user.name
    else
      user.screen_name
    end
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
