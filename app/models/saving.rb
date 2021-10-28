class Saving < ApplicationRecord
    belongs_to :user
    validates :saving_type,presence: true
    validates :amount,presence: true
end
