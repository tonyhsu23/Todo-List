class TodosController < ApplicationController
  before_action :login_required

  def index
    list = current_user.lists.find(params[:list_id])
    @list = list.to_json
    all_todos = list.todos.all
    @todos = all_todos.to_json
    Rails.logger.debug @todos.inspect
  end

  def create
    list = current_user.lists.find(params[:list_id])
    @todo = list.todos.build(todo: params[:todo], done: params[:done])
    Rails.logger.debug params.inspect

    @todo.save

    respond_to do |format|
      format.json { render json: @todo }
    end
  end

  def update
    Rails.logger.debug params.inspect
    list = current_user.lists.find(params[:list_id])
    @todo = list.todos.find(params[:id])

    @todo.update(done: params[:done])

    respond_to do |format|
      format.json { render json: @todo }
    end
  end

  def destroy
    list = current_user.lists.find(params[:list_id])
    @todo = list.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.json { render json: @todo }
    end
  end

  private
	def todo_params
		params.require(:group).permit(:todo, :done)
	end

end
