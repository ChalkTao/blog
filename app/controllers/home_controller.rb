class HomeController < ApplicationController
  def index
  end

  def about
  end

  def search
    @q = Article.ransack(params[:q])
    @articles = Kaminari.paginate_array(@q.result).page(params[:page]) 
  end

  def article
  	@article = Article.find(params[:id])
  	@article.visited
   	@prev = Article.where(:created_at.lt => @article.created_at).desc(:created_at).first
    @next = Article.where(:created_at.gt => @article.created_at).asc(:created_at).first
  end

  def articles
    @articles = Kaminari.paginate_array(Article.all).page(params[:page])
  end

  def categories
  	@labels = Label.all
    @categories = Category.all
  end

  def category
    @category = Category.find(params[:id])
    @articles = Kaminari.paginate_array(Article.where(:category => @category.name).desc(:created_at)).page(params[:page]) 
  end

  def label
    @label = Label.find(params[:id])
    @articles = Kaminari.paginate_array(Article.where(:id.in => @label.article_ids).desc(:created_at)).page(params[:page]) 
  end
end
