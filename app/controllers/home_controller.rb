class HomeController < ApplicationController
  def index
  end

  def about
  end

  def search
    @q = Article.ransack(params[:q])
    @articles = Kaminari.paginate_array(@q.result, :draft => false).page(params[:page]) 
  end

  def article
  	@article = Article.find(params[:id])
  	@article.visited
   	@prev = Article.where(:created_at.lt => @article.created_at, :draft => false).desc(:created_at).first
    @next = Article.where(:created_at.gt => @article.created_at, :draft => false).asc(:created_at).first
  end

  def articles
    @articles = Kaminari.paginate_array(Article.where(:draft => false)).page(params[:page])
  end

  def categories
  	@labels = Label.all
    @categories = Category.all
  end

  def category
    @category = Category.find(params[:id])
    @articles = Kaminari.paginate_array(Article.where(:category => @category.name, :draft => false).desc(:created_at)).page(params[:page]) 
  end

  def label
    @label = Label.find(params[:id])
    @articles = Kaminari.paginate_array(Article.where(:id.in => @label.article_ids, :draft => false).desc(:created_at)).page(params[:page]) 
  end
end
