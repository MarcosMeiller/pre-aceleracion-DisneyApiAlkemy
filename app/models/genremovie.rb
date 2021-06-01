class Genremovie < ApplicationRecord
  belongs_to :movie
  belongs_to :genre
end
