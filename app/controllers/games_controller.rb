class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all.order(created_at: :desc)
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
    @employees = get_all_employees
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    # must access Employee through a helper method
    w = get_employee(params[:game][:winner])
    l = get_employee(params[:game][:loser])

    if w.rank > l.rank # expected
        windiff = 1/(Math::log( [(l.rank-w.rank).abs, 1].max ));
    else # unexpected
        windiff = Math::log( [(l.rank-w.rank).abs, 1.3].max );
    end

    frommid = 500/(((l.rank-w.rank).abs/2 - 500).abs)**(1.6);

    # delta = (1/(Math::log( [(l.rank-w.rank).abs, 1].max )))**(2)*(500/( (l.rank-w.rank).abs/2 - 500 ).abs)
    delta = windiff * frommid;

    # nwr = [w.rank + delta, 1000].min
    # nlr = [l.rank - delta, 1].max

    nwr = w.rank + 20*[Math::log((w.rank - l.rank).abs, 15),1].max
    nlr = l.rank - 20*[Math::log((w.rank - l.rank).abs, 15),1].max

    @game.wrank = nwr
    @game.lrank = nlr

    w.update(rank: nwr)
    l.update(rank: nlr)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:winner, :loser, :played)
    end
end
