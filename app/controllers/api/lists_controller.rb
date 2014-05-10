class Api::ListsController < Api::BaseController

  before_filter :authenticate_user!

  def index
    render json: lists
  end

  def show
    render json: list
  end

  def create
    render json: lists.create(list_params)
  end

  def update
    list.update(list_params)
    render nothing: true 
  end

  def destroy
    list.destroy
    render nothing: true
  end

  private

    def board
      @boards ||= current_user.boards.find(params[:board_id])
    end

    def lists
      @lists ||= board.lists
    end

    def list
      @list ||= lists.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :priority)
    end

  
end