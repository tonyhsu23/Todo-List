class TodosController < ApplicationController
  before_action :login_required

  def index
    all_todos = Todo.all
    @todos = all_todos.to_json
    Rails.logger.debug all_todos.inspect
  end

  def create
    @todo = Todo.new(todo: params[:todo], done: params[:done])
    Rails.logger.debug params.inspect

    @todo.save

    respond_to do |format|
      format.json { render json: @todo }
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
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
