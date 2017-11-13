module RoomsHelper
  def room_name(room)
    if room.user_id == current_user.id
      User.find(room.other_user_id).screen_name
    else
      User.find(room.user_id).screen_name
    end
  end
end
