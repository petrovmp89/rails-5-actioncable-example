class NewsController < ApplicationController
  def index
    @news_item = News.main_authored_item
  end

  def new
    @news_item = News.main_authored_item || News.new
  end

  def create
    @news_item = News.new(news_params)
    respond_to do |format|
      if @news_item.save
        format.html { redirect_to '/admin', notice: t('.news_item_created') }
      else
        format.html { render :new }
      end
    end
  end

  private

  def news_params
    params.require(:news).permit(:header, :annotation, :expired_at, :authored_item)
  end
end
