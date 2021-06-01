class Movie < ApplicationRecord
    has_many :character_movies
    has_many :characters , through: :character_movies

    has_many :Genremovies
    has_many :genres , through: :Genremovies

end
