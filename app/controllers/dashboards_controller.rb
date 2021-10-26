class DashboardsController < ApplicationController

def index
  @savings = Saving.all
  @expenses = Expense.all
  @allsavings = Saving.sum(:amount)-Expense.sum(:amount)
  @allexpenses = Expense.sum(:amount)
end
end
