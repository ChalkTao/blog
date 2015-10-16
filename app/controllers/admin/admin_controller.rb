class Admin::AdminController < ActionController::Base
  layout "admin"
  before_action :authenticate_user!
  before_action :rend_side
  private
    # Use callbacks to share common setup or constraints between actions.
    def rend_side
      @side_label = Label.all
    end
end
