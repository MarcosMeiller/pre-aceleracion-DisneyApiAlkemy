class Character < ApplicationRecord
    has_many :character_movies
    has_many :movies, through: :character_movies
    validates :name, presence: true
    validates :history, presence: true, length: { minimum: 10 }
    validates :age, presence: true, numericality: { message: "value seems wrong"}
    validates :weight, presence: true, numericality: { message: "value seems wrong"}

end
