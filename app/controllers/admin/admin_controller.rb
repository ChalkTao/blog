class Admin::AdminController < ActionController::Base
  layout "admin"
  before_action :check_admin
  before_action :rend_side
  private
    # Use callbacks to share common setup or constraints between actions.
    def rend_side
      @side_label = Label.desc(:id).limit(8)
      @side_categories = Category.all
    end

    def check_admin
    	authenticate_user!
    	if current_user.email != Rails.configuration.admin
    		redirect_to root_path
    	end
    end
end
