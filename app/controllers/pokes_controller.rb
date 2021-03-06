class PokesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :im_editor, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  before_action :set_poke, only: [:show, :edit, :update, :destroy]

  def index
    @pokes = Poke.all.order(number: :asc)
  end

  def show
  end

  def pokemon
  end

  def poke_search
    @poke = Poke.where('name like ?', '%' + params[:keyword] + '%').first
  end

  def pokecheck
  end

  def poke_check_search
    @poke = Poke.where('name like ?', '%' + params[:keyword] + '%').first
    @output = params[:output].to_s
  end

  def new
    @poke = Poke.new
  end

  def edit
  end

  def create
    @poke = Poke.new(poke_params)

    respond_to do |format|
      if @poke.save
        format.html { redirect_to @poke, notice: 'Poke was successfully created.' }
        format.json { render :show, status: :created, location: @poke }
      else
        format.html { render :new }
        format.json { render json: @poke.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @poke.update(poke_params)
        format.html { redirect_to @poke, notice: 'Poke was successfully updated.' }
        format.json { render :show, status: :ok, location: @poke }
      else
        format.html { render :edit }
        format.json { render json: @poke.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @poke.destroy
    respond_to do |format|
      format.html { redirect_to pokes_url, notice: 'Poke was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def auto_complete
    @pokes = Poke.select('name').where('name like ?', params[:term].to_s.tr('ぁ-ん','ァ-ン') + '%').order(number: :asc)

    render json: @pokes.to_json
  end

  private
    def set_poke
      @poke = Poke.find(params[:id])
    end

    def poke_params
      params.require(:poke).permit(:name, :h, :a, :b, :c, :d, :s, :type_1, :type_2)
    end

    def im_editor
      if current_user.role != 'editor' &&
      current_user.role != 'admin'
        redirect_to root_path and return
      end
    end
end