class ListsController < ApplicationController
  before_action :login_required

  def index
    all_lists = current_user.lists.all
    @lists = all_lists.to_json
    Rails.logger.debug all_lists.inspect
  end

  def create
    @list = current_user.lists.build(title: params[:title]);
    Rails.logger.debug params.inspect

    @list.save

    respond_to do |format|
      format.json { render json: @list }
    end
  end

  def count
    #count how many todos in a list
    list  = current_user.lists.find(params[:id]);
    todos = list.todos.all
    todo_count = todos.length

    Rails.logger.debug todo_count.inspect

    respond_to do |format|
      format.json { render json: todo_count }
    end
  end

  private
	def list_params
		params.require(:list).permit(:title)
	end
end
