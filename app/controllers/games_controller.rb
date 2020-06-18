class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :im_admin
  before_action :set_game, only: [:show, :edit, :update, :destroy, :up, :down]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all.order(order_num: :asc)
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)
    max = Game.maximum(:order_num)
    if max.present?
      @game.order_num = max + 1
    else
      @game.order_num = 1
    end

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

  def up
    min = Game.minimum(:order_num)
    if @game.order_num != min
      up_game = Game.find_by(order_num: @game.order_num - 1)
      up_game.order_num = @game.order_num
      @game.order_num = @game.order_num - 1

      up_game.save
      @game.save
    end
    redirect_to games_path
  end

  def down
    max = Game.maximum(:order_num)
    if @game.order_num != max
      low_game = Game.find_by(order_num: @game.order_num + 1)
      low_game.order_num = @game.order_num
      @game.order_num = @game.order_num + 1

      low_game.save
      @game.save
    end
    redirect_to games_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.require(:game).permit(:title, :image)
    end

    def im_admin
      if !current_user.admin
        redirect_to root_path and return
      end
    end
end
