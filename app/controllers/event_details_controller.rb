class EventDetailsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event_detail, only: [:show, :edit, :update, :destroy]

  # GET /event_details
  # GET /event_details.json
  def index
    @event_details = EventDetail.where(latest: true)
                                .where('date > ?', Time.now)
                                .order(date: :asc)
  end

  # GET /event_details/1
  # GET /event_details/1.json
  def show
  end

  # GET /event_details/new
  def new
    @event_detail = EventDetail.new
  end

  # GET /event_details/1/edit
  def edit
  end

  # POST /event_details
  # POST /event_details.json
  def create
    @event_detail = EventDetail.new(event_detail_params)
    @event_detail.user_id = current_user.id
    @event_detail.latest = true
    event = Event.create
    @event_detail.event_id = event.id

    respond_to do |format|
      if @event_detail.save
        format.html { redirect_to @event_detail, notice: 'Event detail was successfully created.' }
        format.json { render :show, status: :created, location: @event_detail }
      else
        format.html { render :new }
        format.json { render json: @event_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_details/1
  # PATCH/PUT /event_details/1.json
  def update
    @new_event_detail = EventDetail.new(event_detail_params)
    @new_event_detail.user_id = current_user.id
    @new_event_detail.latest = true
    @new_event_detail.event_id = @event_detail.event.id

    respond_to do |format|
      if @new_event_detail.save
        if @event_detail.update(latest: false)
          format.html { redirect_to @new_event_detail }
          format.json { render :show, status: :ok, location: @new_event_detail }
        else
          format.html { render :edit }
          format.json { render json: @new_event_detail.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @event_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event_detail.destroy
    respond_to do |format|
      format.html { redirect_to event_details_url, notice: 'Event detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def game
    @game = Game.find params[:id]
    @event_details = EventDetail.where(latest: true)
                                .where(game_id: params[:id])
                                .where('date > ?', Time.now)
                                .order(date: :asc)

    render 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_detail
      @event_detail = EventDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_detail_params
      params.require(:event_detail).permit(:game_id, :owner, :title, :text, :date, :latest, :boolean, :event_id)
    end
end
