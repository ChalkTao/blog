class HomeController < ApplicationController
  def index
  end

  def welcome
  end

  def about
  end

  def search
  end

  def article
  	@article = Article.find(params[:id])
  	@article.visited
   	@prev = Article.where(:created_at.lt => @article.created_at).desc(:created_at).first
    @next = Article.where(:created_at.gt => @article.created_at).asc(:created_at).first
  end

  def category
  	@labels = Label.all
  end

  def label
    @label = Label.find(params[:id])
    @articles = Article.where(:id.in => @label.article_ids).desc(:created_at)
  end
end
