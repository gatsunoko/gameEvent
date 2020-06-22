class EventDetailsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event_detail, only: [:show, :edit, :update, :destroy]
  before_action :can_edit, only: [:edit, :update, :destroy]

  def index
    @event_details = EventDetail.where(latest: true)
                    .where('date > ?', Date.today - 1)
                    .order(date: :asc)
                    .page(params[:page])
                    .per(25)
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render :show }
    end
  end

  def new
    @event_detail = EventDetail.new
  end

  def edit
  end

  def create
    @event_detail = EventDetail.new(event_detail_params)
    @event_detail.user_id = current_user.id
    @event_detail.latest = true

    event = Event.create(user_id: current_user.id)
    @event_detail.event_id = event.id

    respond_to do |format|
      if @event_detail.save
        format.html { redirect_to @event_detail, notice: 'Event detail was successfully created.' }
        format.json { render :show, status: :created, location: @event_detail }
      else
        event.destroy
        format.html { render :new }
        format.json { render json: @event_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @event_detail = EventDetail.new(event_detail_params)
    # @event_detail.user_id = current_user.id
    # @event_detail.latest = true
    # @event_detail.event_id = @event_detail.event.id

    # respond_to do |format|
    #   if @event_detail.save
    #     if @event_detail.update(latest: false)
    #       format.html { redirect_to @event_detail }
    #       format.json { render :show, status: :ok, location: @event_detail }
    #     else
    #       format.html { render :edit }
    #       format.json { render json: @event_detail.errors, status: :unprocessable_entity }
    #     end
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @event_detail.errors, status: :unprocessable_entity }
    #   end
    # end

    respond_to do |format|
      if @event_detail.update(event_detail_params)
        format.html { redirect_to @event_detail }
        format.json { render :show, status: :ok, location: @event_detail }
      else
        format.html { render :edit }
        format.json { render json: @event_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event_detail.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Event detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def game
    @game = Game.find params[:id]
    @event_details = EventDetail.where(latest: true)
                    .where(game_id: params[:id])
                    .where('date > ?', Date.today - 1)
                    .order(date: :asc)
                    .page(params[:page])
                    .per(25)
  end

  def tag_search
    #検索
    if params[:keyword].present?
      sp = params[:keyword].gsub("　"," ")#全角スペースを半角スペースに変換
      sp.chop! if sp[sp.length-1] == " "#最後の文字がスペースだったら削除
      sp = sp.gsub(" ","%,%")#半角スペースをカンマに変換(プレスホルダーの第二引数以降に使用する変数spに代入)
      sp = '%'+sp+'%'
      sp = sp.split(",")#ひとつの文字列だったspをカンマで区切って配列にする

      eventTags = Array.new

      sp.each.with_index do |keyword, i|
        if i > 0
          eventTags = eventTags & Tag.where('title like ?', keyword).pluck(:event_detail_id)
        else
          eventTags.push(*Tag.where('title like ?', keyword).pluck(:event_detail_id))
        end
      end

      @game = Game.find params[:game_id] if params[:game_id].present?
      if eventTags.present?
        @event_details = EventDetail.where(latest: true)
                        .game_search(params[:game_id].to_s)#scope
                        .tags_search(eventTags)#scope
                        .order(date: :asc)
                        .distinct
                        .page(params[:page])
                        .per(25)
        #検索結果に表示にするタグ一覧ほインスタンス変数に保存
        @searchTags = params[:keyword].gsub("　"," ")
      else
        @event_details = EventDetail.none
                        .page(params[:page])
                        .per(25)
      end
    else
      if params[:game_id].present?
        redirect_to game_event_details_path(id: params[:game_id]) and return
      else
        redirect_back(fallback_location: root_path) and return
      end
    end

    render 'game' and return
  end

  private
    def set_event_detail
      @event_detail = EventDetail.find(params[:id])
    end

    def can_edit
      if @event_detail.event.user_id != current_user.id &&
      current_user.role != 'editor' &&
      current_user.role != 'admin'
        redirect_to root_path and return
      end
    end

    def event_detail_params
      params.require(:event_detail).permit(
        :game_id,
        :owner,
        :title,
        :text,
        :date,
        :latest,
        :boolean,
        :event_id,
        :image,
        tags_attributes: [
          :title,
          :id,
          :_destroy],
      )
    end
end
