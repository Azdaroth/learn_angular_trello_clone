class Api::BoardsController < Api::BaseController

  before_filter :authenticate_user!

  def index
    render json: current_user.boards
  end

  def show
    render json: current_user.boards.find(params[:id])
  end

  def create
    render json: current_user.boards.create(board_params)
  end

  def update
    current_user.boards.find(params[:id]).update(board_params)
    render nothing: true 
  end

  def destroy
    current_user.boards.find(params[:id]).destroy
    render nothing: true
  end

  private

    def board_params
      params.require(:board).permit(:name, :priority)
    end

end
