class Menu < ApplicationRecord
  validates :category, presence: true
  validates :substances, presence: true

end