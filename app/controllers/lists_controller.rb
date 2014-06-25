class ListsController < ApplicationController
  before_action :login_required

  def index
    all_lists = current_user.lists.all
    @lists = all_lists.to_json
    Rails.logger.debug all_lists.inspect
  end

  def create
    @list = current_user.lists.build(title: params[:title], count: 0);
    Rails.logger.debug params.inspect

    @list.save
    
    respond_to do |format|
      format.json { render json: @list }
    end
  end

  def destroy
    @list = current_user.lists.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private
	def list_params
		params.require(:list).permit(:title)
	end
end
