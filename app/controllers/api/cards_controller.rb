class Api::CardsController < Api::BaseController
  
  before_filter :authenticate_user!

  def index
    render json: cards
  end

  def show
    render json: card
  end

  def create
    render json: list.cards.create(card_params)
  end

  def update
    card.update(card_params)
    render nothing: true 
  end

  def destroy
    card.destroy
    render nothing: true
  end

  private

    def board
      @boards ||= current_user.boards.find(params[:board_id])
    end

    def list
      @list ||= board.lists.find(params[:list_id])
    end

    def cards
      @cards ||= list.cards
    end

    def card
      @card ||= current_user.cards.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:name, :priority, :description, :list_id)
    end


end