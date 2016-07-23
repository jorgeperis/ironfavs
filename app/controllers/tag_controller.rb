class TagController < ApplicationController

  def show
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create



    @tag = Tag.new(name: params[:tag][:name])
    if Tag.all.empty?
      color = Color.first
    else
      if Color.exists? id: Tag.last.color.id + 1
        color = Color.find(Tag.last.color.id + 1)
      else
        color = Color.first
      end
    end
    @tag.color = color

    if @tag.save
      @tag.save
      redirect_to '/tags'
    else
      a = "The name of the tag is already in use"
      render text: a
    end

  end

end
