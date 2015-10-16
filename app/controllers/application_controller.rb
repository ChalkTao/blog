class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :rend_side
  private
    # Use callbacks to share common setup or constraints between actions.
    def rend_side
      @side_label = Label.all
      @recent_articles = Article.all.order(:created_at => :desc).limit(3)
    end
end
