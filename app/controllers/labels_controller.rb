class LabelsController < ApplicationController
  def index
  	@labels = Label.all
  end

  def show
    @label = Label.find(params[:id])
    @articles = Article.where(:id.in => @label.article_ids).desc(:created_at)
  end
end
