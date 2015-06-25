class MatchesController < ApplicationController
  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.order(:date).includes(:winner, :loser).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  # POST /matches
  # POST /matches.json
  def create
    @match = Match.new(match_params)

    respond_to do |format|
      if @match.save
        format.html { redirect_to matches_path, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @match }
      else
        format.html { render :new }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:winner_id, :loser_id, :date, :loser_score)
    end
end
