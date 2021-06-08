class Movie < ApplicationRecord
    has_many :character_movies
    has_many :characters , through: :character_movies

    has_many :Genremovies
    has_many :genres , through: :Genremovies

    validates :title, presence: true
    validates :image, presence: true
    validates :rating, presence: true, numericality: { message: "value seems wrong"}
    validates :creation_date, presence: true
end
