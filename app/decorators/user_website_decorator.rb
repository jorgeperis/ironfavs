class UserWebsiteDecorator < Draper::Decorator
  delegate_all

  def name_of_website
    if user_website.website_name.length > 20
      user_website.website_name[0..17] + "..."
    else
      user_website.website_name
    end
  end

end
