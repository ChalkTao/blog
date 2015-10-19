class Admin::ArticlesController < Admin::AdminController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_label, only: [:new, :edit]

  include ApplicationHelper

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.desc(:created_at)
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
    labels = params[:article].delete(:labels).to_s
    initialize_or_create_labels(labels)

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
    initialize_or_create_labels(labels)

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
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    render plain: markdown(params[:content])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def set_label
      @labels = Label.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def initialize_or_create_labels(labels)
      @article.labels = []
      labels.split(",").each do |name|
        label = Label.find_or_initialize_by(name: name.strip)
        label.save!
        @article.labels << label
      end
    end
end
