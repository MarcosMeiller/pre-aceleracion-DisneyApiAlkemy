class Genre < ApplicationRecord
    has_many :Genremovies
    has_many :movies , through: :Genremovies
end
