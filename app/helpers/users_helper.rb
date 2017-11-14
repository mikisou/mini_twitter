# frozen_string_literal: true

module UsersHelper
  def render_user_screen_name(user)
    if user.screen_name.blank?
      user.name
    else
      user.screen_name
    end
  end

  def current_user?(user)
    user.id == current_user.id
  end
end
