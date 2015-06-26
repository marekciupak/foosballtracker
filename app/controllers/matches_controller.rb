class MatchesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @matches = Match.order(:date).includes(:winner, :loser).paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      info = "The number of points for players in the ranking system has changed:
      #{@match.winner.fullname}: #{sprintf("%.1f", @match.winner.rank)},
      #{@match.loser.fullname}: #{sprintf("%.1f", @match.loser.rank)}."

      redirect_to matches_path, notice: 'Match was successfully created. ' + info
    else
      render :new
    end
  end

  private
    def match_params
      params.require(:match).permit(:winner_id, :loser_id, :date, :loser_score)
    end
end
