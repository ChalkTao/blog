class Admin::ArticlesController < Admin::AdminController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_label, only: [:new, :edit]
  before_action :set_default_category, only: [:create, :update]

  include ApplicationHelper

  # GET /articles
  # GET /articles.json
  def index
    @articles = Kaminari.paginate_array(Article.desc(:created_at)).page(params[:page])
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    respond_to do |format|
      format.html { }
      format.json { render :json=> {
        title: @article.title,
        labels: @article.labels_content(true),
        content: @article.content
      }
     }
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    if params[:article][:draft] === "false"
      labels = params[:article].delete(:labels).to_s
      initialize_or_create_labels(labels)
      add_category(params[:article][:category])
    end

    respond_to do |format|
      if @article.save
        format.html { redirect_to [:admin, @article], notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    labels = params[:article].delete(:labels).to_s
    puts "---------------------------"

    if !params[:article][:draft] || params[:article][:draft] === "false"
      initialize_or_create_labels(labels)
      if !@article.draft
        minus_category(@article.category)
      end
      add_category(params[:article][:category])
    end

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to [:admin, @article], notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if !@article.draft
      minus_category(@article.category)
    end
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    render plain: markdown(params[:content])
  end

  def search
    @q = Article.ransack(params[:q])
    @articles = Kaminari.paginate_array(@q.result).page(params[:page])
  end

  def draft
    @articles = Kaminari.paginate_array(Article.where(:draft => true)).page(params[:page])
  end

  def upload
    put_policy = Qiniu::Auth::PutPolicy.new(Rails.configuration.qiniu_bucket)
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    render :json=> { uptoken: uptoken }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_label
      @labels = Label.all
      @categories = Category.all
      @domain = Rails.configuration.qiniu_domain
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :category, :draft)
    end

    def initialize_or_create_labels(labels)
      @article.labels = []
      labels.split(",").each do |name|
        label = Label.find_or_initialize_by(name: name.strip)
        @article.labels << label
        label.save!
      end
    end

    def set_default_category
      if !params[:article][:category] || params[:article][:category] == nil
        params[:article][:category] = "未分类"
      end
    end

    def add_category(name)
      category = Category.find_or_initialize_by(name: name)
      category.update_count(1)
    end

    def minus_category(name)
      category = Category.find_or_initialize_by(name: name)
      category.update_count(-1)
    end
end
