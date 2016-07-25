class TagDecorator < Draper::Decorator
  # delegate_all

  def createSize(maxLength)
      case object.websites.length
      when 0...(0.2*maxLength) then size = 1
      when (0.2*maxLength)...(0.4*maxLength) then size = 2
      when (0.4*maxLength)...(0.6*maxLength) then size = 3
      when (0.6*maxLength)...(0.8*maxLength) then size = 4
        else size = 5
      end
  end

end
