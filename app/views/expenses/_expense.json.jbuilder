json.extract! expense, :id, :expense_type, :amount, :date, :created_at, :updated_at
json.url expense_url(expense, format: :json)