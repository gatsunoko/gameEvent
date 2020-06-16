class EventDetailsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event_detail, only: [:show, :edit, :update, :destroy]
  before_action :can_edit, only: [:edit, :update]

  def index
    @event_details = EventDetail.where(latest: true)
                                .where('date > ?', Date.today - 1)
                                .order(date: :asc)
  end

  def show
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

    if params.dig(:event, :edit_others) == 'true'
      edit_others = true
    else
      edit_others = false
    end
    event = Event.create(edit_others: edit_others, user_id: current_user.id)
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
                                .where('date > ?', Date.today - 1)
                                .order(date: :asc)

    render 'index'
  end

  def tag_search
    #パラメーターが空だったらトップへ
    redirect_to root_path and return if params[:keyword].blank?
    #検索
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
    @event_details = EventDetail.where(latest: true)
                    .game_search(params[:game_id].to_s)#scope
                    .where(id: eventTags)
                    .order(date: :asc)
                    .distinct
    #検索結果に表示にするタグ一覧ほインスタンス変数に保存
    @searchTags = params[:keyword].gsub("　"," ")

    render 'index'
  end

  private
    def set_event_detail
      @event_detail = EventDetail.find(params[:id])
    end

    def can_edit
      if !@event_detail.event.edit_others &&
          @event_detail.event.user_id != current_user.id
        redirect_to root_path and return
      end
    end

    def event_detail_params
      params.require(:event_detail).permit(:game_id,
                                           :owner,
                                           :title,
                                           :text,
                                           :date,
                                           :latest,
                                           :boolean,
                                           :event_id,
                                           tags_attributes: [:title, :_destroy],)
    end

end
