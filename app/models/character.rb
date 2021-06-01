class Character < ApplicationRecord
    has_many :character_movies
    has_many :movies, through: :character_movies

end
