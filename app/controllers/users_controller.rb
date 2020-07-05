class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :role_edit, :role_update]
  before_action :is_admin, only: [:index, :role_edit, :role_update]
  before_action :set_user, only: [:show, :edit, :update, :role_edit, :role_update]
  before_action :is_mine, only: [:edit, :update]

  def index
    @users = User.all
                 .page(params[:page])
                 .per(25)
  end

  def show
    @event_details = EventDetail.where(user_id: @user.id)
                                .order(updated_at: :desc)
                                .page(params[:page])
                                .per(25)

    render 'event_details/index'
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      render 'edit'
    end
  end

  def role_edit
  end

  def role_update
    # raise.params.inspect
    @user.update(user_role_params)
    redirect_to users_path
  end

  private
    def is_admin
      if current_user.role != 'admin'
        redirecto_to root_path
      end
    end

    def is_mine
      if @user.id != current_user.id &&
      current_user.role != 'admin'
        redirect_to root_path and return
      end
    end

    def set_user
      @user = User.find params[:id]
    end

    def user_params
      params.require(:user).permit(
        :name
      )
    end

    def user_role_params
      params.require(:user).permit(
        :role
      )
    end
end
