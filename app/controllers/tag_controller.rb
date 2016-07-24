class TagController < ApplicationController

  def show
    @tags = current_user.tags.all
  end

  def new
    @tag = Tag.new
  end

  def create

    tag = Tag.new(name: params[:tag][:name])
    if current_user.tags.all.empty?
      color = Color.first
    else
      if Color.exists? id: current_user.tags.last.color.id + 1
        color = Color.find(current_user.tags.last.color.id + 1)
      else
        color = Color.first
      end
    end
    tag.color = color

    if current_user.tags.find_by('lower(name) = ?', tag.name.downcase)
      a = "Tag already exists in your database"
      render text: a
    else
      if tag.save
        tag.save
        current_user.tags.push(tag)
        redirect_to '/tags'
      else
        render text: tag.errors.full_messages
      end
    end


  end

end
