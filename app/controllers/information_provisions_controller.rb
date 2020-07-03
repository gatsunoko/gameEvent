class InformationProvisionsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :destroy]
  before_action :can_edit, only: [:index, :destroy]
  before_action :set_information_provision, only: [:show, :destroy]

  def index
    @information_provisions = InformationProvision.all
                                                  .order(date: :asc)
                                                  .page(params[:page])
                                                  .per(25)
  end

  def show
  end

  def new
    @information_provision = InformationProvision.new
  end

  # def edit
  # end

  def create
    @information_provision = InformationProvision.new(information_provision_params)

    respond_to do |format|
      if @information_provision.save
        format.html { redirect_to @information_provision, notice: 'Information provision was successfully created.' }
        format.json { render :show, status: :created, location: @information_provision }
      else
        format.html { render :new }
        format.json { render json: @information_provision.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @information_provision.update(information_provision_params)
  #       format.html { redirect_to @information_provision, notice: 'Information provision was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @information_provision }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @information_provision.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @information_provision.destroy
    respond_to do |format|
      format.html { redirect_to information_provisions_url, notice: 'Information provision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_information_provision
      @information_provision = InformationProvision.find(params[:id])
    end

    def information_provision_params
      # params.fetch(:information_provision, {})
      params.require(:information_provision).permit(
        :game_id,
        :owner,
        :title,
        :text,
        :date,
        :name,
        :contact
      )
    end

    def can_edit
      if current_user.role != 'contributor' &&
      current_user.role != 'editor' &&
      current_user.role != 'admin'
        redirect_to root_path and return
      end
    end
end
