class DashboardsController < ApplicationController
  before_action :authenticate_user!

def index
  @savings = Saving.all
  @expenses = Expense.all
  @allsavings = current_user.savings.sum(:amount)-current_user.expenses.sum(:amount)
  @allexpenses = current_user.expenses.sum(:amount)
end
end
