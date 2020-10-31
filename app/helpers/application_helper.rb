module ApplicationHelper
  def translate_msg_type(msg_type)
    case msg_type
    when "error"
      "danger"
    else
      msg_type
    end
  end
end
