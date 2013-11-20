class PlayerScoresController < ApplicationController
  before_action :set_player_score, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:create]
 
  # GET /player_scores
  # GET /player_scores.json
  def index
    @match = Match.find(params[:match_id])
    @player_scores = @match.player_scores.paginate(page: params[:page], per_page: 5)
  end

  # GET /matches/1/innings/4/player_scores
  def innindex
    @match = Match.find(params[:match_id])
    #binding.pry
    @innings = @match.innings.find(params[:id])
    @player_scores = @innings.player_scores
    render :index
  end

  # GET /player_scores/1
  # GET /player_scores/1.json
  def show
    @match = Match.find(params[:match_id])
  end

  # GET /player_scores/new
  def new
    @match = Match.find(params[:match_id])
    @player_score = PlayerScore.new
    binding.pry
  end

  # GET /player_scores/1/edit
  def edit
    @match = Match.find(params[:match_id])
  end

  # POST /player_scores
  # POST /player_scores.json
  def create
    @match = Match.find(params[:match_id])
    @player_score = PlayerScore.new(player_score_params)

    respond_to do |format|
      if @player_score.save
        format.html { redirect_to match_player_score_path(@match, @player_score), notice: 'Player score was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @player_score }
        format.json { render action: 'show', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_scores/1
  # PATCH/PUT /player_scores/1.json
  def update
    @match = Match.find(params[:match_id])
    respond_to do |format|
      if @player_score.update(player_score_params)
        format.html { redirect_to match_player_score_path(@match, @player_score), notice: 'Player score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_scores/1
  # DELETE /player_scores/1.json
  def destroy
    @player_score.destroy
    respond_to do |format|
      format.html { redirect_to match_player_scores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_score
      @player_score = PlayerScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_score_params
      params.require(:player_score).permit(:name, :match_id, :innings_id, :bat_minutes, :bat_how, :bat_not_outs, :bat_runs_scored, :bat_balls, :bat_fours, :bat_sixes, :bat_sr, :bowl_overs, :bowl_maidens, :bowl_runs, :bowl_wickets, :bowl_wides, :bowl_noballs, :bowl_er, :field_catches, :field_stumpings, :field_runouts)
    end
end