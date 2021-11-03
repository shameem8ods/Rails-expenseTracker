class SavingsController < ApplicationController
  before_action :set_saving, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update,:destroy,:show]


  def index
    @savings = Saving.all
  end

  def new
    @saving = Saving.new
  end

  def edit
  end

  def create
    @saving = Saving.new(saving_params)
    respond_to do |format|
      if @saving.save
        format.js
        flash[:notice]="Saving was successfully created"
        redirect_to root_path
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @saving.update(saving_params)
        format.js
        flash[:notice]="Saving was successfully updated"
        redirect_to root_path
      else
        format.js
      end
    end
  end

  def destroy
    @saving.destroy
    flash[:notice]="Saving was successfully destroyed"
        redirect_to root_path
  end

  def correct_user
    @saving = current_user.savings.find_by(id: params[:id])
    redirect_to root_path, notice: "Not autherised to do this action" if @saving.nil?
  end

private
    def set_saving
      @saving = Saving.find(params[:id])
    end

    def saving_params
      params.require(:saving).permit(:saving_type, :amount, :date,:user_id)
    end
end
