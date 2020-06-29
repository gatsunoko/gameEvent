class HomeController < ApplicationController
  def index
    @event_details = EventDetail.where(latest: true)
                                .where('date > ?', Time.now.ago(3.hours))
                                .order(date: :asc)
                                .limit(5)
                                .offset(0)
    @gameList = Game.all.order(title: :asc)
    @games = Game.all.order(order_num: :asc)
  end
end
