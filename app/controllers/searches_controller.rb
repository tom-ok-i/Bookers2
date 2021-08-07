class SearchesController < ApplicationController
  def search
    @model = params["search"]["model"]
    @value = params["search"]["value"]
    @how = params["search"]["how"]
    @datas = search_for(@model, @value, @how)
  end


  private

  def matching(model, value)
    if model == 'user'
      User.where(name: value)
    elsif model == 'book'
      Book.where(title: value)
    end
  end

  def forward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?","#{value}%")
    end
  end

  def backward(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}")
    elsif model == 'book'
      Book.where("title LIKE ?","%#{value}")
    end
  end

  def partial(model, value)
    if model == 'user'
      User.where("name LIKE ?", "%#{value}%")
    elsif model == 'book'
      Book.where("title LIKE ?","%#{value}%")
    end
  end

  def search_for(model, value, how)
    case how
    when 'match'
      matching(model, value)
    when 'forward'
      forward(model, value)
    when 'backward'
      backward(model, value)
    when 'partial'
      partial(model, value)
    end
  end
end
