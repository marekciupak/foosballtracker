class PlayersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all.order(rank: :desc)
  end

  def show
    @matches = Match.played_by(@player).order(:date).includes(:winner, :loser).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @player = Player.new
  end

  def edit
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def update
    if @player.update(player_params)
      redirect_to @player, notice: 'Player was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    
    redirect_to players_url, notice: 'Player was successfully destroyed.'
  end

  private
    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:firstname, :lastname, :email)
    end
end
