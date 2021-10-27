class Expense < ApplicationRecord
    validates :expense_type,presence: true
    validates :amount,presence: true
end
