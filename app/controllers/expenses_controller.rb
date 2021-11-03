class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update,:destroy,:show]

  def index
    @expenses = Expense.all
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)
    respond_to do |format|
      if @expense.save
       format.js
       flash[:notice]="Expense was successfully created"
        redirect_to root_path
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.js
        flash[:notice]="Expense was successfully updated"
        redirect_to root_path
      else
        format.js
      end
    end
  end

  def destroy
    @expense.destroy
    flash[:notice]="Expense was successfully deleted"
    redirect_to root_path
  end

  def correct_user
    @expense = current_user.expenses.find_by(id: params[:id])
    redirect_to root_path, notice: "Not autherised to do this action" if @expense.nil?
  end

private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:expense_type, :amount, :date,:user_id)
    end
end
