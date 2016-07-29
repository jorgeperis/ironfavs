class UserWebsiteDecorator < Draper::Decorator
  delegate_all

  def name_of_website
    if user_website.website_name.length > 15
      user_website.website_name[0..12] + "..."
    else
      user_website.website_name
    end
  end

end
