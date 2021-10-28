class Expense < ApplicationRecord
    belongs_to :user
    validates :expense_type,presence: true
    validates :amount,presence: true
end
