class TagUserDecorator < Draper::Decorator
  delegate_all

  def relative_size_for_user(max_websites_tag)
      case TagWebsite.count_websites_for_a_tag(self.user_id,self.tag_id)
      when 0...(0.2*max_websites_tag) then 1
      when (0.2*max_websites_tag)...(0.4*max_websites_tag) then 2
      when (0.4*max_websites_tag)...(0.6*max_websites_tag) then 3
      when (0.6*max_websites_tag)...(0.8*max_websites_tag) then 4
      else 5
      end
  end

end
