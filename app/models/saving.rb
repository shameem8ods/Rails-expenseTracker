class Saving < ApplicationRecord
    validates :saving_type,presence: true
    validates :amount,presence: true
end
