class WebsiteDecorator < Draper::Decorator
  delegate_all

  def screenshot
    website.avatar.url(:medium)
  end

end
