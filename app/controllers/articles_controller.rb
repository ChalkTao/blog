class ArticlesController < ApplicationController
  def show
  	@article = Article.find(params[:id])
  	@article.visited
   	@prev = Article.where(:created_at.lt => @article.created_at).desc(:created_at).first
    @next = Article.where(:created_at.gt => @article.created_at).asc(:created_at).first
  end
end
